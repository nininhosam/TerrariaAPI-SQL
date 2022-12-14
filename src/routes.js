const { Router } = require('express');
const ItemsController = require('./controllers/ItemsController');
const routes = Router();

routes.get(`/`, ItemsController.list);
routes.get(`/:id`, ItemsController.listItem);
routes.post(`/`, ItemsController.createItem);
routes.put(`/:id`, ItemsController.fixItem);
routes.delete(`/:id`, ItemsController.deleteItem);
module.exports = routes;