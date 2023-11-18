-- 2 kyu, 11 mo

module EvaluateMathematicalExpression (calc) where
import Data.Char (isNumber, isDigit, isSpace)
import Text.Parsec

dot = satisfy (== '.') :: Parsec String () Char

lp = satisfy (== '(') :: Parsec String () Char
rp = satisfy (== ')') :: Parsec String () Char

ws = satisfy isSpace :: Parsec String () Char

number = do
    a <- many1 digit
    (do dot
        b <- many digit
        pure (a ++ '.':b))
        <|> pure a

data Expr =
        Primary Double
      | Neg Expr
      | Binary Op Expr Expr
      | Paren Expr deriving (Show, Eq)

data Op = ADD | SUB | MUL | DIV | MULNEG | DIVNEG deriving (Show, Eq)

mul = do
        satisfy (== '*')
        (do 
            xs <- many1 (satisfy (== '-') :: Parsec String () Char)
            pure $ if even (length xs) then MUL else MULNEG) <|> pure MUL
add = do
        satisfy (== '+')
        (do 
            xs <- many1 (satisfy (== '-') :: Parsec String () Char)
            pure $ if even (length xs) then ADD else SUB) <|> pure ADD
sub = do
        satisfy (== '-')
        (do 
            xs <- many1 (satisfy (== '-') :: Parsec String () Char)
            pure $ if even (length xs) then SUB else ADD) <|> pure SUB
div' = do
        satisfy (== '/')
        (do 
            xs <- many1 (satisfy (== '-') :: Parsec String () Char)
            pure $ if even (length xs) then DIV else DIVNEG) <|> pure DIV

binaryAssocLeft p op = chainl1 p (do op <- op
                                     pure $ \x y -> Binary op x y)

primary = (do
            neg <- option "" (many1 $ satisfy (== '-'))
            (do lp
                t <- term
                rp
                pure (if odd $ length neg then Neg t else t) 
                <|> (do
                        num <- number
                        let v = Primary (read num :: Double)
                        pure (if odd $ length neg then Neg v else v))))

factor = do
    cont <- binaryAssocLeft primary (mul <|> div')
    pure cont

term = do
    cont <- binaryAssocLeft factor (add <|> sub)
    pure cont

expr = term

parser = parse expr ""

run exp = case exp of
    Primary p -> p
    Neg n -> - run n
    Binary op l r -> 
        let l' = run l in
            let r' = run r in
                case op of 
                    ADD -> l' + r'
                    SUB -> l' - r'
                    MUL -> l' * r' 
                    DIV -> l' / r'
                    MULNEG -> l' * (-r')
                    DIVNEG -> l' / (-r')
    Paren p -> run p

calc :: String -> Double
calc source= case parse expr "" (filter (not . isSpace) source) of
    Left err -> error $ show err
    Right exp -> run exp

go = parse expr "" . filter (not . isSpace)