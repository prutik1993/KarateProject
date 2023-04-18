package TechGlobal;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import com.intuit.karate.junit5.Karate;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class TechGlobalTest {

    // @Test
    // void testParallel() {
    //     Results results = Runner.path("classpath:TechGlobal")
    //             //.outputCucumberJson(true)
    //             .parallel(5);
    //     assertEquals(0, results.getFailCount(), results.getErrorMessages());
    // }


    // @Karate.Test
    // Karate testAll() {
    //     return Karate.run().relativeTo(getClass());
    // }

    @Karate.Test
    Karate testTags() {
        return Karate.run().tags("@tg").relativeTo(getClass());
    }

}