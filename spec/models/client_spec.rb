require 'spec_helper'

describe Client do
  describe "#waiting_list" do
    it "does not include voided clients" do
      create(:client, application_voided: true)
      expect(Client.waiting_list).to be_empty
    end
    it "orders clients by application date" do
      client_2 = create(:client, application_date: 2.weeks.ago)
      client_1 = create(:client, application_date: 3.weeks.ago)
      client_3 = create(:client, application_date: 1.weeks.ago)
      expect(Client.waiting_list).to eq([client_1, client_2, client_3])

    end
    it "does not include completed clients" do
      create(:client, pickup_date: 1.week.ago)
      expect(Client.waiting_list).to be_empty
    end
  end

  describe "#closed_applications" do
    it "orders chronologically by date bike was picked up" do
      client_1 = create(:client, pickup_date: 1.week.ago)
      client_3 = create(:client, pickup_date: 3.week.ago)
      client_2 = create(:client, pickup_date: 2.week.ago)
      expect(Client.closed_applications).to eq([client_1, client_2, client_3])
    end
  end

  describe "on update" do

    it "updates client's bike_assigned_date if a bike is assigned" do
      date = Time.zone.now.beginning_of_day
      client = create :client
      bike = create :bike
      Timecop.freeze(date) do
        client.update_attribute(:bike, bike)
        expect(client.reload.assigned_bike_at).to eq(date)
      end
    end

    it "does not update client's bike_assigned_date if a bike is assigned" do
      date = Time.zone.now.beginning_of_day
      client = create :client
      Timecop.freeze(date) do
        client.update_attribute(:first_name, "freddy")
        expect(client.reload.assigned_bike_at).to eq(nil)
      end
    end
  end

end
