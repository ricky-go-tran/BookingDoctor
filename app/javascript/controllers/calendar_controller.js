import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["target"];
  connect() {
    this.render();
  }
  render() {
    let ec = new EventCalendar(document.getElementById("time-grid"), {
      view: "timeGridWeek",
      height: "500px",
      headerToolbar: {
        start: "prev,next today",
        center: "title",
        end: "dayGridMonth,timeGridWeek,timeGridDay",
      },
      buttonText: function (texts) {
        texts.resourceTimeGridWeek = "resources";
        return texts;
      },
      resources: [
        { id: 1, title: "You" },
        { id: 2, title: "Other" },
      ],
      scrollTime: "07:00:00",
      events: this.createEvents(),
      views: {
        timeGridWeek: { pointer: false },
        resourceTimeGridWeek: { pointer: false },
      },
      eventDragStart: function(event) {
        event.preventDefault();
      },
      dayMaxEvents: false,
      nowIndicator: true,
      allDaySlot: false,
      dragScroll: false
    });
  }
  createEvents() {
    let days = [];
    for (let i = 0; i < 7; ++i) {
      let day = new Date();
      let diff = i - day.getDay();
      day.setDate(day.getDate() + diff);
      days[i] =
        day.getFullYear() +
        "-" +
        this._pad(day.getMonth() + 1) +
        "-" +
        this._pad(day.getDate());
    }
    console.log(typeof (days[0] + " 00:00"))
    return [
      {
        start: days[0] + " 00:00 UTC",
        end: days[0] + " 09:00",
        resourceId: 1,
        display: "background",
      },
      {
        start: days[1] + " 12:00",
        end: days[1] + " 14:00",
        resourceId: 2,
        display: "background",
      },
      {
        start: days[2] + " 17:00",
        end: days[2] + " 24:00",
        resourceId: 1,
        display: "background",
      },
      {
        start: days[0] + " 10:00 UTC",
        end: days[0] + " 14:00 UTC",
        resourceId: 2,
        title: "An event may span to another day",
      },
      {
        start: days[1] + " 16:00",
        end: days[2] + " 08:00",
        resourceId: 2,
        title: "An event may span to another day",
        color: "#B29DD9",
      },
      {
        start: days[2] + " 09:00",
        end: days[2] + " 13:00",
        resourceId: 2,
        title:
          "Events can be assigned to resources and the calendar has the resources view built-in",
        color: "#779ECB",
      },
      {
        start: days[3] + " 14:00",
        end: days[3] + " 20:00",
        resourceId: 1,
        title: "",
        color: "#FE6B64",
      },
      {
        start: days[3] + " 15:00",
        end: days[3] + " 18:00",
        resourceId: 1,
        title: "Overlapping events are positioned properly",
        color: "#779ECB",
      },
      {
        start: days[5] + " 10:00",
        end: days[5] + " 16:00",
        resourceId: 2,
        titleHTML:
          "You have complete control over the <i><b>display</b></i> of events…",
        color: "#779ECB",
      },
      {
        start: days[5] + " 14:00",
        end: days[5] + " 19:00",
        resourceId: 2,
        title: "…and you can drag and drop the events!",
        color: "#FE6B64",
      },
      {
        start: days[5] + " 18:00",
        end: days[5] + " 21:00",
        resourceId: 2,
        title: "",
        color: "#B29DD9",
      }
    ];
  }
  _pad(num) {
    let norm = Math.floor(Math.abs(num));
    return (norm < 10 ? "0" : "") + norm;
  }
}
