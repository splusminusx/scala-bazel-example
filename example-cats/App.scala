import cats.syntax.functor._
import cats.effect.{IOApp, ExitCode, IO}

import example.common.Person

object App extends IOApp {

  val usage = "Usage: example-cats name"

  def greet(person: Person): String = s"Hello, ${person.name}"

  def run(args: List[String]): IO[ExitCode] =
    args.headOption match {
      case Some(name) =>
        IO {
          val person = Person(name = name)
          println(greet(person))
        }.as(ExitCode.Success)
      case None =>
        IO {
          System.err.println(usage)
        }.as(ExitCode(2))
    }  
}
