{-# LANGUAGE OverloadedStrings, ForeignFunctionInterface #-}
{-# LANGUAGE EmptyDataDecls             #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE FlexibleInstances           #-}
{-# LANGUAGE GADTs                      #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE OverloadedStrings          #-}
{-# LANGUAGE QuasiQuotes                #-}
{-# LANGUAGE TemplateHaskell            #-}
{-# LANGUAGE TypeFamilies               #-}

module Blockchain.Data.DataDefs (
  BlockData (..),
  Block (..),
  BlockRef (..),
  AddressState (..),
  SignedTX (..),
  SHA (..),
  Address (..),
  SHAPtr (..),
  entityDefs,
  migrateAll 
  ) where

import Database.Persist
import Database.Persist.Types
import Database.Persist.TH
import Database.Persist.Postgresql
import Database.Persist.Quasi
 
--import Database.Persist.EntityDef
import Data.Time
import Data.Time.Clock.POSIX
import Data.ByteString as B

import Blockchain.Data.Address
import Blockchain.SHA
import Blockchain.Data.SignedTransaction
import Blockchain.Util

import Blockchain.Database.MerklePatricia



--import Debug.Trace

entityDefs :: [EntityDef]
entityDefs = $(persistFileWith lowerCaseSettings "src/Blockchain/Data/DataDefs.txt")
  
share [mkPersist sqlSettings, mkMigrate "migrateAll"] 
    $(persistFileWith lowerCaseSettings "src/Blockchain/Data/DataDefs.txt")


