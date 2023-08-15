# frozen_string_literal: true

module Clinic
  module ClinicProfilesHelper
    def total_price(service_items, prescription_items)
      sum = 0
      service_items.each do |item|
        sum += item.price
      end
      prescription_items.each do |item|
        sum += (item.price * item.amount)
      end
      sum
    end
  end
end
