Feature: MusicBrainz metadata lookup
  In order to obtain quality metadata for an audio CD
  As a discerning music listener
  I want to lookup audio metadata from MusicBrainz

  @ext
  Scenario: Lookup metadata for a disc with UTF-8 metadata
    Given an audio CD with MusicBrainz DiscID "ofNUMtU1O38OTXZBTop_w9LG.O4-"
    When I lookup metadata for the CD
    Then the "ARTIST" field should be "Björk"
    And the "ARTISTSORT" field should be "Björk"
    And the "ALBUM" field should be "Medúlla"
    And the "MUSICBRAINZ_ALBUMTYPE" field should be "Album"
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

  @ext
  Scenario: Lookup metadata for the first disc of a two disc set
    Given an audio CD with MusicBrainz DiscID "sZcWz4uVPpz0VegORgkXVJHaLrs-"
    When I lookup metadata for the CD
    Then the "ARTIST" field should be "The Smashing Pumpkins"
    And the "ALBUM" field should be "Mellon Collie and the Infinite Sadness"
    And the "ARTISTSORT" field should be "Smashing Pumpkins"
    And the "DATE" field should be "1995-10-24"
    #And the "DISCNUMBER" field should be "1"
    #And the "DISCTOTAL" field should be "2"

  @ext
  Scenario: Lookup metadata for a multiple artist release
    Given an audio CD with MusicBrainz DiscID "KAzfMjh8wIX2rsWb4LvaNP.GUfU-"
    When I lookup metadata for the CD
    Then the "ALBUM" field should be "Singles"
    And the "MUSICBRAINZ_ALBUMTYPE" field should be "Soundtrack"
    And the "ARTIST" field should be "Various Artists"
    And the "ARTISTSORT" field should be "Various Artists"
    And the "ALBUMARTIST" field should be "Various Artists"
    And the "ALBUMARTISTSORT" field should be "Various Artists"
    And the "COMPILATION" field should be "true"
    And the tracks should be:
      | Title                          | Artist                | ArtistSort        |
      | Would?                         | Alice in Chains       | Alice in Chains   |
      | Breath                         | Pearl Jam             | Pearl Jam         |
      | Seasons                        | Chris Cornell         | Cornell, Chris    |
      | Dyslexic Heart                 | Paul Westerberg       | Westerberg, Paul  |
      | Battle of Evermore             | Lovemongers           | Lovemongers       |
      | Chloe Dancer / Crown of Thorns | Mother Love Bone      | Mother Love Bone  |
      | Birth Ritual                   | Soundgarden           | Soundgarden       |
      | State of Love and Trust        | Pearl Jam             | Pearl Jam         |
      | Overblown                      | Mudhoney              | Mudhoney          |
      | Waiting for Somebody           | Paul Westerberg       | Westerberg, Paul  |
      | May This Be Love               | Jimi Hendrix          | Hendrix, Jimi     |
      | Nearly Lost You                | Screaming Trees       | Screaming Trees   |
      | Drown                          | The Smashing Pumpkins | Smashing Pumpkins |
  