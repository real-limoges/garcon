module Garcon.App (app) where

import Network.Wai (Application)
import Servant (serve)

import Chompsky.Config (AppConfig)
import Garcon.API (api)
import Garcon.Server (server)

app :: AppConfig -> Application
app cfg = serve api (server cfg)
