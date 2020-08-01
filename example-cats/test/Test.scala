import org.scalatest._

class TestSuite extends FlatSpec {
  "App" should "show usage" in {
    assert(App.usage == "Usage: example-cats name")
  }

  "App" should "show name" in {
    assert(App.greet("User") == "Hello, User.")  
  }
}
