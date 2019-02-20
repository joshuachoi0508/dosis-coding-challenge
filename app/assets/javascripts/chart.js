document.addEventListener('DOMContentLoaded', () => {
    let parsedReadings = readings.slice(1, readings.length - 1).replaceAll(" ", "").split(',').map(reading => {
        if (reading === "nil") {
            return null;
        } else {
            return parseFloat(reading)
        }
    });
    let parsedDates = dates.slice(1, dates.length - 1).replaceAll(" ", "").replaceAll("&quot;", "").split(',');
    let parsedAmounts = amounts.slice(1, amounts.length - 1).replaceAll(" ", "").split(',').map(reading => {
            if (reading === "nil") {
                return null;
            } else {
                return Number(reading)
            }
        }
    );
    Highcharts.chart('container', {
        chart: {
            zoomType: 'xy'
        },
        title: {
            text: 'Pannel Information'
        },
        xAxis: [{
            categories: parsedDates,
            crosshair: true
        }],
        yAxis: [{ // Primary yAxis
            labels: {
                format: '{value} pts',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            },
            title: {
                text: 'Readings',
                style: {
                    color: Highcharts.getOptions().colors[1]
                }
            }
        }, { // Secondary yAxis
            title: {
                text: 'Amounts',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            labels: {
                format: '{value} units',
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            opposite: true
        }],
        tooltip: {
            shared: true
        },
        legend: {
            layout: 'vertical',
            align: 'left',
            x: 120,
            verticalAlign: 'top',
            y: 100,
            floating: true,
            backgroundColor: (Highcharts.theme && Highcharts.theme.legendBackgroundColor) || 'rgba(255,255,255,0.25)'
        },
        series: [{
            name: 'Amount',
            type: 'column',
            yAxis: 1,
            data: parsedAmounts,
            tooltip: {
                valueSuffix: ' units'
            }
    
        }, {
            name: 'Reading',
            type: 'spline',
            data: parsedReadings,
            tooltip: {
                valueSuffix: ' pts'
            }
        }]
    });
})