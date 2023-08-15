from unittest import IsolatedAsyncioTestCase, TestCase, main
from dict_util import flatten_dict_with_dots

class Test(TestCase):

    def test_simple(self):
        test_dict = {
            "a": "a",
            "b": "b"
        }
        self.assertEqual(test_dict, flatten_dict_with_dots(test_dict))

    def test_simple_with_nested(self):
        test_dict = {
            "a": "a",
            "b": "b",
            "c": {
                "a": "a",
                "b": "b"
            }
        }
        self.assertEqual(test_dict["a"], flatten_dict_with_dots(test_dict)["a"])
        self.assertEqual(test_dict["b"], flatten_dict_with_dots(test_dict)["b"])

    def test_nested(self):
        test_dict = {
            "a": "a",
            "b": "b",
            "c": {
                "a": "a",
                "b": "b"
            }
        }
        expected_dict = {
            "a": "a",
            "b": "b",
            "c.a": "a",
            "c.b": "b"
        }
        self.assertEqual(expected_dict, flatten_dict_with_dots(test_dict))

if __name__ == "__main__":
    main()
