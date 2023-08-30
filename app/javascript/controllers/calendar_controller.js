import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["data"];
  initialize() {
    this.calendarInstance = null;
  }
  connect() {
    this.render();
    this.observeBookingViewsChanges();
  }
  render() {
    if (this.calendarInstance != null) {
      this.calendarInstance.destroy();
    }
    this.calendarInstance = new EventCalendar(this.dataTarget, {
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
    var data = this.dataTarget;
    return JSON.parse(data.dataset.bookingViews);
  }

  observeBookingViewsChanges() {
    const observer = new MutationObserver((mutationsList) => {
      for (const mutation of mutationsList) {
        if (
          mutation.type === "attributes" &&
          mutation.attributeName === "data-booking-views"
        ) {
          this.handleBookingViewsChange();
        }
      }
    });

    observer.observe(this.dataTarget, {
      attributes: true,
      attributeFilter: ["data-booking-views"],
    });
  }
  handleBookingViewsChange() {
    this.render();
  }
  _pad(num) {
    let norm = Math.floor(Math.abs(num));
    return (norm < 10 ? "0" : "") + norm;
  }

  changed() {
    console.log("Hello");
  }
}
