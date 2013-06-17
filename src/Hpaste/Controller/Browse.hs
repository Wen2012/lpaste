{-# OPTIONS -Wall #-}
{-# LANGUAGE OverloadedStrings #-}

-- | Browse page controller.

module Hpaste.Controller.Browse
  (handle)
  where

import Hpaste.Types
import Hpaste.Model.Channel  (getChannels)
import Hpaste.Model.Language (getLanguages)
import Hpaste.Model.Paste    (getPaginatedPastes,countPublicPastes)
import Hpaste.View.Browse    (page)

import Text.Blaze.Pagination
import Snap.App

-- | Browse all pastes.
handle :: HPCtrl ()
handle = do
  pn <- getPagination "pastes"
  author <- getStringMaybe "author"
  (pn',pastes) <- model $ getPaginatedPastes author (pnPn pn)
  chans <- model getChannels
  langs <- model getLanguages
  output $ page pn { pnPn = pn' } chans langs pastes author
