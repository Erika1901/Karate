Feature: Post API Demo

  Background:
    * url 'https://reqres.in/api'
    * header Accept = 'application/json'
    * def expectedOutput = read('response1.json')

  #simple Post scenario
  Scenario: Post Demo 1
    Given url 'https://reqres.in/api/users'
    And   request { "name":"erika", "job": "leader" }
    When  method POST
    Then  status 201
    And   print response

    #Post with Background
  Scenario: Post Demo 2
    Given path '/users'
    And   request { "name":"Malika", "job": "teacher" }
    When  method POST
    Then  status 201
    And   print response

  #Post with assertions
  Scenario: Post Demo 3
    Given path '/users'
    And   request { "name":"Malika", "job": "teacher" }
    When  method POST
    Then  status 201
    And   match response == {"name": "Malika","job": "teacher","id": "#string","createdAt": "#ignore"}
    And   print response

    #Post with read response from file
  Scenario: Post Demo 4
    Given path '/users'
    And   request { "name":"Malika", "job": "teacher" }
    When  method POST
    Then  status 201
    And   match response == expectedOutput
    And   match $ == expectedOutput
    And   print response

    #Read body data from file
  Scenario: Post Demo 5
    Given path '/users'
    And   def projectPath = karate.properties ['user.dir']
    And   print projectPath
    And   def filePath = projectPath+'\src\test\java\tests\request1.json'
    And   print filePath
    And   def requestBody = projectPath+'\src\test\java\tests\request1.json'
    And   request requestBody
    When  method POST
    Then  status 201
    And   match response == expectedOutput
    And   match $ == expectedOutput
    And   print response

     #Post with read response from file
  Scenario: Post Demo 6
    Given path '/users'
    And   def reqBody = read("request1.json")
    And   request reqBody
    And   set reqBody.job = 'engineer'
    When  method POST
    Then  status 201
    And   match response == expectedOutput
    And   match $ == expectedOutput
    And   print response