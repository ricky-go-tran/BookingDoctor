# frozen_string_literal: true

class Admin::ReportsController < Admin::BaseController
  def index
    @reports = if params[:search]
                 Report.search(params[:search])
               else
                 Report.all
               end

    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = 'attachment; filename="all_categories.xlsx"'
        render xlsx: 'index', layout: false
      end
    end
  end

  def show; end
end
