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
      events: this.handleData(),
      views: {
        timeGridWeek: { pointer: false },
        resourceTimeGridWeek: { pointer: false },
      },
      eventDragStart: function (event) {
        event.preventDefault();
      },
      dayMaxEvents: false,
      nowIndicator: true,
      allDaySlot: false,
      dragScroll: false,
    });
  }
  handleData() {
    var data = document.getElementById("time-grid");
    return JSON.parse(data.dataset.bookingViews);
  }
  _pad(num) {
    let norm = Math.floor(Math.abs(num));
    return (norm < 10 ? "0" : "") + norm;
  }
}
