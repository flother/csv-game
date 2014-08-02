{-# LANGUAGE BangPatterns, ScopedTypeVariables, NoMonomorphismRestriction #-}

import Control.Monad
import qualified Data.ByteString as B
import Data.Csv.Incremental
import System.Exit
import System.IO


main :: IO ()
main = withFile "/dev/stdin" ReadMode $ \ csvFile -> do
    let loop !_ (Fail _ errMsg) = putStrLn errMsg >> exitFailure
        loop acc (Many rs k) = loop (acc + sumFields rs) =<< feed k
        loop acc (Done rs) = putStrLn $ show (sumFields rs + acc)

        feed k = do
            isEof <- hIsEOF csvFile
            if isEof
                then return $ k B.empty
                else k `fmap` B.hGetSome csvFile 4096
    loop 0 (decode NoHeader)
  where
    sumFields rs = sum [5| Right (_ :: String, _ :: String, _ :: String, _ :: String, _ :: String) <- rs]
