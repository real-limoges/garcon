module Garcon.App (app) where

import Network.Wai (Application)
import Servant (serve)

import Garcon.API (api)
import Garcon.Server (server)

app :: Application
app = serve api server