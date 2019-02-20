# Quick rails app w/ graph

### Technologies explored
* **Ruby on Rails** (latest stable) — with Turbolinks
* **Postgres** (≥ 10)
* **HighCharts JS** —
  [here's an example][highcharts example]
* **FactoryBot**
* _Don't_ use a frontend library like **React**
* Whatever engineering principles you think help you solve this best

#### Schema Specifics
You are building, at minimum, a single Show view for a Panel.
Panels have a Battery-Specific id which is unique within that Battery.

A given Battery is made up of Panels. Panels can be swapped between Batteries
and may be used in one active Battery at a time.

Panels have two specific metrics we want to keep track of, and we want to track
both metrics in terms of which Battery the Panel was a part of at that time.
  * Consumption Readings (`Reads`) happen about once weekly 5.0 - 18.0.
  * Energy Ratings (`Ratings`) are two to three times a week 200 - 20_000,
    and are skipped about 5-10% of the time

Advisements are given every couple of weeks or so, and propose new
Energy Ratings if Consumption Readings drop below that Battery's setting for
lower targets or climb above that Battery's setting for upper targets. Target
range could be a range of around 3 to 5 pts somewhere in the middle of Reads.

##### Help, what is a Battery Panel?
You can think of a Battery as a Library, with Panels as Books.
A book might move to different branches sometimes, and end up at a
different library. Consumption Readings are performance metrics for these Books
and Energy Ratings are test enhancements to improve those performance metrics.
Someone is calculating relationships between these metrics and tests, and
coming up with Ideas to improve them, which is analogous to Advisements.

#### Panel Show View
Display relevant `Panel` information useful to see.
We use [Slim templating](http://slim-lang.com/) for our main frontend setup.

##### Panel Show View (Graph)
Should take up the top portion of the page. MVP:
  * Show every date in January 2019
  * Visualize a Panel's relevant data points.
  * Don't display Advisements in the graph.

```

┌─────────────────────────────────────────────────────────────────────────────┐
│                                                                             │▒
│             ╔═══════════╗                          .●◟                      │▒
│             ║           ║                        ,'   ╰◟                    │▒
│             ╚═════════▿═╝                      ,'       `╮                  │▒
│                       ●─.            ●────────●           ╲                 │▒
│                      ◜   `───.    ,─'                      `◟,              │▒
│                     ╱         ╲  ╱                            ╲             │▒
│    ●─────────●     ╱           ◝●                              ●            │▒
│               ╲   ╱                                                 █  █    │▒
│                ╲ ╱                                          █  █    █  █    │▒
│                 ●    █                                      █  █    █  █    │▒
│            █  █  █   █   █  █      █  █ █      █  █         █  █    █  █    │▒
│            █  █  █   █   █  █      █  █ █      █  █         █  █    █  █    │▒
│            █  █  █   █   █  █      █  █ █      █  █         █  █    █  █    │▒
└─────────────────────────────────────────────────────────────────────────────┘▒
 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓

```


##### Panel Show View (Table)
Should take up the bottom portion of the page. Decide the best way to edit a
given date's Advisement. See the example row structures below.

###### Regular view mode (allow toggle between two table view modes):
|  Date  |Reading |Amount |Advisement|                     |
|:------:|:------:|:-----:|:--------:|:-------------------:|
|01-02-19|10.4 pts|  n/a  | 600 units|**[Edit Advisement]**|

###### Enhanced view mode (allow toggle between two table view modes):
| PID | SID |  Date  |Reading |  Amount |Advisement|Acceptance|% Accepted|
|:---:|:---:|:------:|:------:|:-------:|:--------:|:--------:|:--------:|
| 123 | A04 |01-13-19|  n/a   |900 units| 900 units|    n/a   |   100%   |
| 123 | A04 |01-11-19| 9.0 pts|800 units|    n/a   |   88.9   |    67%   |
| 123 | A04 |01-08-19|  n/a   |600 units|    n/a   |    n/a   |    67%   |
| 123 | A04 |01-05-19|  n/a   |600 units|    n/a   |    n/a   |    67%   |
| 123 | A04 |01-02-19|10.4 pts|   n/a   | 600 units|   57.7   |    n/a   |

###### Possible Table display values
  * **PID**         (Panel db id)
  * **SID**         (Panel Battery Specific id, see above)
  * **Date**
  * **Reading**
  * **Amount**
  * **Advisement**
  * **Acceptance**  (Amount, or Advisement, / Reading)
  * **% Accepted**  (see below)
  * **Button**

###### % Accepted
  > Separate the calculation of `% Accepted` to an ActiveSupport Concern, don't
    clutter the model(s)/controller(s) with this logic

  Calculate a percent of accepted Rating amounts in a given span between two
  Advisements and display that through the lifespan of the Advisement. An
  Advisement should be considered active from the date it is created until
  the next Advisement datum.

### Our Part
We'll run the usual `bundle exec...` `foo`, `bar`, etc. to have a look at what
you've built.


[highcharts example]: https://jsfiddle.net/gh/get/library/pure/highcharts/highcharts/tree/master/samples/highcharts/demo/bar-stacked/
