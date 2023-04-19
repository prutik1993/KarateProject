Feature: Dummy

Scenario: Dummy
    * def dataGeneratot = Java.type('helpers.DataGenerator')
    * def username = dataGeneratot.getRandonUsername()
