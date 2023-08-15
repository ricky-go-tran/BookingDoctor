import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["dataset"];
  connect() {
    this.draw();
  }

  draw() {
    var ctx = document.getElementById("myChart");
    var myChart = new Chart(ctx, {
      type: "line",
      data: {
        labels: Object.keys(JSON.parse(ctx.dataset.appointmentViews)),
        datasets: [
          {
            label: "Appointment",
            data: Object.values(JSON.parse(ctx.dataset.appointmentViews)),
            fill: false,
            borderColor: "#7a7bfc",
            pointBackgroundColor: "#7a7bfc",
            pointBorderWidth: 2,
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderWidth: 2,
            lineTension: 0.05,
          },
          {
            label: "Attendance",
            data: Object.values(JSON.parse(ctx.dataset.attendanceViews)),
            fill: false,
            borderColor: "#ffa766",
            pointBackgroundColor: "#ffa766",
            pointBorderWidth: 2,
            pointHoverBackgroundColor: "#fff",
            pointHoverBorderWidth: 2,
            lineTension: 0.05,
          }
        ],
      },
      options: {
        legend: { display: false },
        scales: {
          xAxes: [
            {
              gridLines: { display: false },
            },
          ],
          yAxes: [
            {
              gridLines: {
                color: "rgba(0, 0, 0, .05)",
              },
            },
          ],
        },
      },
    });
  }
}
