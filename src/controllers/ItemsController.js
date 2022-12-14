const db = require('../database');
async function getItem(param) {
  return new Promise((resolve, reject) => {
    db.query(
      `select
      items.id,
      items.name, 
      items.obtained
      from items
      where items.name like '${param}';`,
      (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result);
      }
    );
  });
}
async function execQuery(itemName) {
  return new Promise((resolve, reject) => {
    db.query(
      `select 
        items.name,
        craftings.amount,
        i2.name material
        from items
        inner join craftings on items.id = craftings.result
        inner join items i2 on i2.id = craftings.material
        where items.name like '${itemName}';`,
      (error, result) => {
        if (error) {
          return reject(error);
        }
        resolve(result);
      }
    );
  });
}
async function loopObject(obj) {
  const elements = {};
  const keys = Object.keys(obj);
  try {
    for (let i = 0; i < keys.length; i++) {
      const data = await execQuery(obj[keys[i]].material);
      //Isn't craftable
      if (data == 0) {
        //only 1 for crafting
        if (obj[keys[i]].amount === 1) {
          elements[obj[keys[i]].material] = obj[keys[i]].material;
        }
        //more than 1 for crafting
        else {
          elements[`${obj[keys[i]].material} x${obj[keys[i]].amount}`] =
            obj[keys[i]].material;
        }
      }
      //is craftable
      else {
        //only one for crafting
        if (obj[keys[i]].amount === 1) {
          elements[obj[keys[i]].material] = await loopObject(
            await execQuery(obj[keys[i]].material)
          );
        }
        //more than 1 for crafting
        else {
          elements[`${obj[keys[i]].material} x${obj[keys[i]].amount}`] =
            await loopObject(await execQuery(obj[keys[i]].material));
        }
      }
    }
  } catch (error) {
    res.status(500).send(error);
  } finally {
    return elements;
  }
}
async function checkRecipe(obj) {
  let check = true;
  let keys = Object.keys(obj.recipe);
  for (i = 0; i < keys.length; i++) {
    const recipeItem = await getItem(keys[i]);
    if (recipeItem.length == 0) {
      check = false;
      console.log(`${keys[i]} does not exist.`);
    }
  }

  return check;
}
async function addItem(obj) {
  let name = obj.name;
  let obtained = obj.obtained;
  db.query(
    `insert into items (name, obtained) values ('${name}', '${obtained}');`,
    (err) => {
      if (err) return err
    }
  );
  return;
}
async function addRecipe(obj) {
  const result = await getItem(obj.name);
  const keys = Object.keys(obj.recipe);

  for (i = 0; i < keys.length; i++) {
    let material = await getItem(keys[i]);
    db.query(
      `insert into craftings (result, material, amount) values (${result[0].id}, ${material[0].id}, ${obj.recipe[keys[i]]});`,
      (err) => {
        if (err) return err
      }
    );
  }
}

const ItemsController = {
  //Shows database of items
  async list(req, res) {
    db.query('SELECT * FROM items', (err, result) => {
      if (err)
        res.status(500).json({
          error: 'Algo deu errado',
          message: err,
        });

      res.send(result);
    });
  },
  //Shows either "Not craftable" "Non-existent" or the crafting tree of the requested item
  async listItem(req, res) {
    const { id } = req.params;
    db.query(
      `select 
        items.name,
        craftings.amount,
        i2.name material
        from items
        inner join craftings on items.id = craftings.result
        inner join items i2 on i2.id = craftings.material
        where items.name like "${id}";`,
      async (err, result) => {
        if (err)
          res.status(500).json({
            error: 'Algo deu errado',
            message: err,
          });
        if (result == 0) {
          const data = await getItem(id);
          if (data == 0) {
            res.status(400).send('This item does not exist');
          } else {
            res.send(data[0].obtained);
          }
        } else {
          const objRes = { ...result };
          const itemTree = {
            [result[0].name]: await loopObject(objRes),
          };
          res.send(itemTree);
        }
      }
    );
  },
  //Add an item and it's recipe
  async createItem(req, res) {
    const newItem = req.body;

    if (Object.keys(newItem).length == 0) {
      res.status(400).send('Please send a valid item');
    } else {
      const itemName = newItem.name;
      const data = await getItem(itemName);
      if (data != 0) {
        res.status(400).send('This item already exists');
      } else {
        if (newItem.name === undefined || newItem.obtained === undefined) {
          res.status(400).send('Invalid request format');
        } else if (
          newItem.recipe == null ||
          Object.keys(newItem.recipe).length == 0
        ) {
          addItem(newItem);
          res.status(201).send('Successfully created item no recipe');
        } else {
          if ((await checkRecipe(newItem)) == true) {
            await addItem(newItem);
            await addRecipe(newItem);
            res.status(201).send('Successfully created item with recipe');
          } else {
            res.status(400).send("One or more recipe items don't exist");
          }
        }
      }
    }
  },
  //Edit an item or recipe (Change name, Change obtained, change recipe(?))
  async fixItem(req, res) {
    const { id } = req.params;
    const newItem = req.body;
    const item = await getItem(id);

    if (newItem.obtained !== undefined) {
      db.query(
        `
      update items
      set obtained = '${newItem.obtained}'
      where name = '${item[0].name}';`,
      (err, row) => {
        if (err)
          res.status(500).json({
            error: 'Algo deu errado',
            message: err,
          });
      }
      );
    }
    if (newItem.name !== undefined) {
      db.query(
        `
      update items
      set name = '${newItem.name}'
      where name = '${item[0].name}';`,
      (err, row) => {
        if (err)
          res.status(500).json({
            error: 'Algo deu errado',
            message: err,
          });
      }
      );
    }
    if (newItem.recipe !== undefined) {
      //if all items exist
      if ((await checkRecipe(newItem)) == true) {
        //delete previous recipe
        db.query(
          `
        delete 
        from craftings 
        where result = '${item[0].id}';`,
          (err, row) => {
            if (err)
              res.status(500).json({
                error: 'Algo deu errado',
                message: err,
              });
          }
        );
        //add it
        await addRecipe(newItem);
      } else {
        res.status(400).send("One or more recipe items don't exist");
      }
    }
    res.send('Fixed');
  },
  //Delete an item and any associated recipes
  async deleteItem(req, res) {
    const { id } = req.params;
    const item = await getItem(id);
    if (item == 0) res.status(400).send('This item does not exist');
    else {
      db.query(
        `delete 
      from items 
      where name = '${id}'`,
        (err, row) => {
          if (err)
            res.status(500).json({
              error: 'Algo deu errado',
              message: err,
            });
        }
      );
      res.status(204).send('Successfully deleted');
    }
  },
};

module.exports = ItemsController;
