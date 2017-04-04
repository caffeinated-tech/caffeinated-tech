
GlossaryRouter = express()

GlossaryRouter.get 
  '/', 
  

GlossaryRouter.get 
  '/more', 
  GlossaryController.listMoreDefinitions

GlossaryRouter.get 
  '/new', 
  Middleware.auth, 
  GlossaryController.newDefinition

GlossaryRouter.get 
  '/edit/:id', 
  Middleware.auth, 
  GlossaryController.editDefinition 

GlossaryRouter.post 
  '/new', 
  Middleware.auth, 
  GlossaryController.saveNewDefinition

GlossaryRouter.post 
  '/edit/:id', 
  Middleware.auth, 
  GlossaryController.saveDefinition 

GlossaryRouter.get 
  '/:id/:slug', 
  GlossaryController.getDefinition

GlossaryRouter.on 'mount', (parent) =>
  console.log 'mounted Glossary'

module.exports = GlossaryRouter
