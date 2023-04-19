Feature: Hooks

Background:
    # * def result = callonce read(‘classpath:helpers/Dummy.feature’)
    # * def username = result.username

#after hooks
* configure afterScenario = function(){ karate.call('class:helpers/Dummy.feature')} // runa after aech scenario
* configure afterFeature = // runs after each feature
"""
    function(){
        karate.log('After Fature Text')
    }
"""

Scenario: First scenario
    * print username
    * print 'This is first scenario'

Scenario: First scenario
    * print username
    * print 'This is second scenario'

