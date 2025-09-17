class StringCalculatorController < ActionController::API
# If using ActionController::Base, add protect_from_forgery with: :null_session

def create
result = StringCalculator.new.add(params[:numbers].to_s)
render json: { result: result }
rescue ArgumentError => e
render json: { error: e.message }, status: :unprocessable_entity
end
end