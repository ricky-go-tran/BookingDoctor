class Admin::ReportsController < Admin::BaseController
  def index
    if params[:search]
      @reports = Report.where("UPPER(title) LIKE UPPER(?)", "%#{params[:search]}%")
    else
      @reports = Report.all
    end
    respond_to do |format|
      format.html
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="all_categories.xlsx"'
        render xlsx: "index", layout: false
      }
    end
  end

  def show

  end
end
