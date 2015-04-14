Feature: Encode a query string

  Scenario:
    Given a query string that requires encoding
    And a value for REQUESTTYPE of SAVE
    And a value for TABLE of undefined
    And a value for GROUP of WEB_RMLEAS
    And a value for PAGE of APPLY
    And a value for ID of MRI_1
    And a value for CMD in command.xml
    And a value for DATA in data.xml
    When the keys and values are encoded
    Then they produce the string in expected_output.txt


