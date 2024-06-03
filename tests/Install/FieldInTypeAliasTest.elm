module Install.FieldInTypeAliasTest exposing (..)

import Install.FieldInTypeAlias
import Run
import Test exposing (Test, describe)


all : Test
all =
    describe "Install.FieldInTypeAlias"
        [ Run.expectNoErrorsTest test1.description test1.src test1.rule
        , Run.testFix test2
        , Run.testFix test3
        ]


test1 =
    { description = "should not report an error when the field already exists"
    , src = """module Client exposing (..)
type alias Client =
    { name : String
    , age : Int
    }
    """
    , rule = Install.FieldInTypeAlias.makeRule "Client" "Client" "name : String"
    }


test2 =
    { description = "should report an error when the field does not exist"
    , src = """module Client exposing (..)
type alias Client =
    { age : Int
    }
    """
    , rule = Install.FieldInTypeAlias.makeRule "Client" "Client" "name : String"
    , under = """type alias Client =
    { age : Int
    }"""
    , fixed = """module Client exposing (..)
type alias Client =
    { age : Int
    , name : String
    }
    """
    , message = "Add name to Client"
    }


test3 =
    { description = "should report an error when the field does not exist in a nested module"
    , src = """module Data.Client exposing (..)
type alias Client =
    { age : Int
    }
    """
    , rule = Install.FieldInTypeAlias.makeRule "Data.Client" "Client" "name : String"
    , under = """type alias Client =
    { age : Int
    }"""
    , fixed = """module Data.Client exposing (..)
type alias Client =
    { age : Int
    , name : String
    }
    """
    , message = "Add name to Client"
    }
