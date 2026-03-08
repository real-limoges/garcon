module Garcon.Server (server) where

import Servant

import Garcon.API (API)

server :: Server API
server = healthHandler :<|> itemsHandler

healthHandler :: Handler String
healthHandler = pure "ok"

itemsHandler :: Handler [String] :<|> (Int -> Handler String)
itemsHandler = listItems :<|> getItem
  where
    listItems = pure ["apple", "banana", "cherry"]
    getItem i = pure ("item-" <> show i)