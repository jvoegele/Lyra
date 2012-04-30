Feature: CD reading
  In order to prepare for ripping a CD
  As a person who continues to buy CDs
  I want to read information about the CD in the CD-ROM drive

  @wip
  Scenario: Read MusicBrainz Disc ID from CD
    Given that there is a CD in the CD-ROM drive
    And the first track number on the CD is 1
    And the CD has 206096 sectors
    And the CD has the following track offsets:
    | 150    |
    | 15658  |
    | 21945  |
    | 43035  |
    | 57588  |
    | 65994  |
    | 83795  |
    | 98319  |
    | 120484 |
    | 135848 |
    | 144815 |
    | 163441 |
    | 181428 |
    | 187780 |
    When CD information is read from the CD
    Then the MusicBrainz Disc ID should be "jKFmXk3up_E2TzfG7EHWCnuhVLs-"
    And the FreeDB ID should be "b50ab90e"
    And there should be 206096 sectors
    And the first track number should be 1
    And the last track number should be 14
    And the total length should be 2748 seconds
    And the track information should be:
    | Track Number | Sectors | Start Sector | End Sector | Duration | Start Time | End Time |
    | 1            | 15508   | 150          | 15658      | 3:27     | 0:02       | 3:29     |
    | 2            | 6287    | 15658        | 21945      | 1:24     | 3:29       | 4:53     |
    | 3            | 21090   | 21945        | 43035      | 4:41     | 4:53       | 9:34     |
    | 4            | 14553   | 43035        | 57588      | 3:14     | 9:34       | 12:48    |
    | 5            | 8406    | 57588        | 65994      | 1:52     | 12:48      | 14:40    |
    | 6            | 17801   | 65994        | 83795      | 3:57     | 14:40      | 18:37    |
    | 7            | 14524   | 83795        | 98319      | 3:14     | 18:37      | 21:51    |
    | 8            | 22165   | 98319        | 120484     | 4:56     | 21:51      | 26:46    |
    | 9            | 15364   | 120484       | 135848     | 3:25     | 26:46      | 30:11    |
    | 10           | 8967    | 135848       | 144815     | 2:00     | 30:11      | 32:11    |
    | 11           | 18626   | 144815       | 163441     | 4:08     | 32:11      | 36:19    |
    | 12           | 17987   | 163441       | 181428     | 4:00     | 36:19      | 40:19    |
    | 13           | 6352    | 181428       | 187780     | 1:25     | 40:19      | 41:44    |
    | 14           | 18316   | 187780       | 206096     | 4:04     | 41:44      | 45:48    |
    
