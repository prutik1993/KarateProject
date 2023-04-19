package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._
import scala.concurrent.duration._
import conduitApp.performance.createTokens.CreateTokens

class PerfTest extends Simulation {

    CreateTokens.createAccessTokens()

  val protocol = karateProtocol(
   "/api/articles/{articleId}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")
  //protocol.runner.karateEnv("perf")

  val csvFeeder = csv("articles.csv").circular
  val tokenFeeder Iterator.continually(Map("email"->CreateTokens.getNextToken))

  val createArticle = scenario("create and delete article")
                       .feed(csvFeeder)
                       .feed(tokenFeeder)
                       .exec(karateFeature("classpath:conduitApp/performance/createArticle.feature"))
  

  setUp(
    createArticle.inject(
        atOnceUser(1),
        nothingFor(4 seconds),
        constatntUsersPerSec(1) during (10 seconds),
        constatntUsersPerSec(2) during (10 seconds),
        rummpUsersPerSec(2) to 10 during (20 seconds),
        nothingFor(5 seconds),
        constatntUsersPerSec(1) during (5 seconds)
         ).protocols(protocol)
   
  )

  // mvn clean test-compile gatheling:test
  // https://gatling.io/docs/current/general/simulation_setup/ 
//   setUp(
//   scn.injectOpen(
//     nothingFor(4), // 1
//     atOnceUsers(10), // 2
//     rampUsers(10).during(5), // 3
//     constantUsersPerSec(20).during(15), // 4
//     constantUsersPerSec(20).during(15).randomized(), // 5
//     rampUsersPerSec(10).to(20).during(10), // 6
//     rampUsersPerSec(10).to(20).during(10).randomized(), // 7
//     stressPeakUsers(1000).during(20) // 8
//   ).protocols(httpProtocol)
// );

}