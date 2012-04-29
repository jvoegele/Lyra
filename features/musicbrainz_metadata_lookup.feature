Feature: MusicBrainz metadata lookup
  In order to obtain quality metadata for an audio CD
  As a discerning music listener
  I want to lookup audio metadata from MusicBrainz

  Scenario: Lookup metadata for MusicBrainz DiscID
    Given an audio CD with MusicBrainz DiscID "ofNUMtU1O38OTXZBTop_w9LG.O4-"
    When I lookup metadata for the CD
    Then the "ARTIST" field should be "Björk"
    And the "ALBUM" field should be "Medúlla"
    And the "DATE" field should be "2004-08-31"
    And the tracks should be:
      | TrackNumber | Title                                                            | Duration |
      | 01          | Pleasure Is All Mine                                             | 3:27     |
      | 02          | Show Me Forgiveness                                              | 1:24     |
      | 03          | Where Is the Line                                                | 4:41     |
      | 04          | Vökuró                                                           | 3:14     |
      | 05          | Öll birtan                                                       | 1:52     |
      | 06          | Who Is It (Carry My Joy on the Left, Carry My Pain on the Right) | 3:57     |
      | 07          | Submarine                                                        | 3:14     |
      | 08          | Desired Constellation                                            | 4:56     |
      | 09          | Oceania                                                          | 3:25     |
      | 10          | Sonnets/Unrealities XI                                           | 2:00     |
      | 11          | Ancestors                                                        | 4:08     |
      | 12          | Mouth's Cradle                                                   | 4:00     |
      | 13          | Miðvikudags                                                      | 1:25     |
      | 14          | Triumph of a Heart                                               | 4:04     |
