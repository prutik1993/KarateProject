package helpers;

import com.github.javafaker.Faker;

import net.minidev.json.JSONObject;

public class dataGenerator {

    public static Faker faker;
    
    public static String getRandomEmail(){

         faker = new Faker();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0,100) + "@test.com";
        //String email = faker.internet().getRandomEmail();
        return email;

    }

    public static String getRandomUsername(){
         faker = new Faker();
        String username = faker.name().username();
        return username;

    }

    public static JSONObject getRandomArticleValues(){
        faker = new Faker();
       String title = faker.gameOfThrones().character();
       String description = faker.gameOfThrones().city();
       String body = faker.gameOfThrones().quote();
       JSONObject json = new JSONObject();
       json.put("title", title);
       json.put("description", description);
       json.put("body", body);

       return json;

   }

}
