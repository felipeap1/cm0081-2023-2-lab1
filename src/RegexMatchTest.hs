module Main (main) where
import Test.HUnit
import Text.Regex.TDFA(RegexLike(matchTest), RegexMaker(makeRegex), Regex)
--qualified prevents error caused by a conflict between both regex libraries
import qualified Text.Regex.Posix

pruebasPosix :: Test
pruebasPosix = test
  [--makeRegex recieves a string and returns a regex
   --matchTest checks if a string belongs to the result of a regex given
    "Identity Test" ~: (Text.Regex.Posix.matchTest
   (Text.Regex.Posix.makeRegex "a" :: Regex) "a" :: Bool) ~?= True,
   --regex "^(a|b)$" is equivalent to a + b or {a, b} for a regex matchTest
   "Union Test" ~: (Text.Regex.Posix.matchTest
    (Text.Regex.Posix.makeRegex "^(a|b)$" :: Regex) "a" :: Bool) ~?= True,
   "Kleene clousure Test" ~: (Text.Regex.Posix.matchTest 
   (Text.Regex.Posix.makeRegex "a*" :: Regex) "aaaa" :: Bool) ~?= True,
   --regex "a" ++ "b" is equivalent to the regex a.b or the word "ab"
   "Concatenation test" ~: (Text.Regex.Posix.matchTest
    (Text.Regex.Posix.makeRegex ("a" ++ "b") :: Regex)  "ab" :: Bool) ~?= True,
   --"a{2}" is equivalent to the regex a^2 or the word "aa"
   "Power test" ~: (Text.Regex.Posix.matchTest 
   (Text.Regex.Posix.makeRegex "a{2}" :: Regex) "aa" :: Bool) ~?= True
  ]
--we try the same we did with regex-posix with regex-tdfa 
pruebasTdfa :: Test
pruebasTdfa = test
  ["Identity Test" ~: (matchTest 
  (makeRegex "a" :: Regex) "a" :: Bool) ~?= True,
   "Union Test" ~: (matchTest 
   (makeRegex "^(a|b)$" :: Regex) "a" :: Bool) ~?= True,
   "Kleene clousure Test" ~: (matchTest
    (makeRegex "a*" :: Regex) "aaaa" :: Bool) ~?= True,
   "Concatenation test" ~: (matchTest 
   (makeRegex ("a" ++ "b") :: Regex)  "ab" :: Bool) ~?= True,
   "Power test" ~: (matchTest 
   (makeRegex "a{2}" :: Regex) "aa" :: Bool) ~?= True
  ]

main :: IO ()
main = do
  counts1 <- runTestTT pruebasPosix
  counts2 <- runTestTT pruebasTdfa
  print counts1
  print counts2
  return()