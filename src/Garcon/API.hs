module Garcon.API (API, api) where

import Servant

type HealthAPI = "health" :> Get '[JSON] String

type ItemsAPI =
    "items" :> Get '[JSON] [String]
        :<|> "items" :> Capture "id" Int :> Get '[JSON] String

type API = HealthAPI :<|> ItemsAPI

api :: Proxy API
api = Proxy