module Reminder (main) where

import Data.Char (isSpace)
import Data.List.Split
import System.Environment

main = do
  g <- getEnv "HOME"
  q <- readFile (g ++ "/.local/lib/Q.txt")
  a <- readFile (g ++ "/.local/lib/A.txt")
  let (que, ans) = mapTuple (splitOn "\n") (q, a)
  let (qPerf, aPerf) = mapTuple (filter (/="")) (que, ans)
  iterateList (qPerf, aPerf)

-- Type Alias
type QnA = [String]

-- Generic Tuple map
mapTuple :: (a -> b) -> (a, a) -> (b, b)
mapTuple f (a1, a2) = (f a1, f a2)

-- Strip List
stripList x = filter (/="") x


-- Iterate IO
iterateList :: (QnA, QnA) -> IO ()
iterateList (x:y, a:b) | y/=[] = do {putStrLn ("> " ++ x); line <- getLine; putStrLn a; putStrLn "" ;iterateList(y, b)}
                       | y==[] = do {putStrLn ("> " ++ x); line <- getLine; putStrLn a; putStrLn "" ;putStrLn "------Finish------"}

