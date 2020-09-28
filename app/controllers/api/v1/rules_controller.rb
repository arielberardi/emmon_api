module Api::V1

  class RulesController < ApplicationController
    include Authentication
    before_action :set_rule, only: [:show, :update, :destroy]
    respond_to :json

    # GET /rules
    # GET /rules.json
    def index
      @rules = Rule.all
    end

    # GET /rules/1
    # GET /rules/1.json
    def show
    end

    # POST /rules
    # POST /rules.json
    def create
      @rule = Rule.new(rule_params)

      if @rule.save
        render :show, status: :created, location: api_v1_rule_url(@rule)
      else
        render json: @rule.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /rules/1
    # PATCH/PUT /rules/1.json
    def update
      if @rule.update(rule_params)
        render :show, status: :ok, location: api_v1_rule_url(@rule)
      else
        render json: @rule.errors, status: :unprocessable_entity
      end
    end

    # DELETE /rules/1
    # DELETE /rules/1.json
    def destroy
      @rule.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_rule
        @rule = Rule.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def rule_params
        params.require(:rule).permit(:section, :can_create, :can_read, :can_update, :can_delete, :role_id)
      end
  end
end 