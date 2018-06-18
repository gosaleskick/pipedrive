# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::Endpoints::Deals do
  let(:token) { OpenStruct.new(access_token: 'access_token', expires_at: 1.day.from_now) }
  let(:client) { Pipedrive::OAuth::Client.new(token: token) }

  describe 'GET /deals' do
    subject { client.deals }

    it 'returns result object with json response', :vcr do
      expect(subject).to be_a(Pipedrive::Result)
      expect(subject.data).to match(
        {
          success: true,
          data: [
            {
              id: 1,
              creator_user_id: {
                id: 5323730,
                name: "Adam Zapaśnik",
                email: "adam@saleskick.co",
                has_pic: false,
                pic_hash: nil,
                active_flag: true,
                value: 5323730
              },
              user_id: {
                id: 5323730,
                name: "Adam Zapaśnik",
                email: "adam@saleskick.co",
                has_pic: false,
                pic_hash: nil,
                active_flag: true,
                value: 5323730
              },
              person_id: {
                name: "me",
                email: [{ value: "", primary: true }],
                phone: [{ value: "", primary: true }],
                value: 7
              },
              org_id: {
                name: "saleskick",
                people_count: 0,
                owner_id: 5323730,
                address: nil,
                cc_email: "adamzapasnik-sandbox@pipedrivemail.com",
                value: 6
              },
              stage_id: 3,
              title: "importantdeal",
              value: 2222,
              currency: "USD",
              add_time: "2018-06-14 11:01:33",
              update_time: "2018-06-18 13:14:02",
              stage_change_time: "2018-06-14 11:01:43",
              active: false,
              deleted: false,
              status: "lost",
              probability: nil,
              next_activity_date: nil,
              next_activity_time: nil,
              next_activity_id: nil,
              last_activity_id: nil,
              last_activity_date: nil,
              lost_reason: ":9",
              visible_to: "3",
              close_time: "2018-06-18 10:49:35",
              pipeline_id: 1,
              won_time: nil,
              first_won_time: nil,
              lost_time: "2018-06-18 10:49:35",
              products_count: 0,
              files_count: 0,
              notes_count: 0,
              followers_count: 1,
              email_messages_count: 0,
              activities_count: 0,
              done_activities_count: 0,
              undone_activities_count: 0,
              reference_activities_count: 0,
              participants_count: 2,
              expected_close_date: nil,
              last_incoming_mail_time: nil,
              last_outgoing_mail_time: nil,
              stage_order_nr: 3,
              person_name: "me",
              org_name: "saleskick",
              next_activity_subject: nil,
              next_activity_type: nil,
              next_activity_duration: nil,
              next_activity_note: nil,
              formatted_value: "$2,222",
              weighted_value: 2222,
              formatted_weighted_value: "$2,222",
              weighted_value_currency: "USD",
              rotten_time: nil,
              owner_name: "Adam Zapaśnik",
              cc_email: "adamzapasnik-sandbox+deal1@pipedrivemail.com",
              org_hidden: false,
              person_hidden: false
            }
          ],
          additional_data: {
            pagination: {
              start: 0,
              limit: 100,
              more_items_in_collection: false
            }
          },
          related_objects: {
            user: {
              "5323730": {
                id: 5323730,
                name: "Adam Zapaśnik",
                email: "adam@saleskick.co",
                has_pic: false,
                pic_hash: nil,
                active_flag: true
              }
            },
            organization: {
              "6": {
                id: 6,
                name: "saleskick",
                people_count: 0,
                owner_id: 5323730,
                address: nil,
                cc_email: "adamzapasnik-sandbox@pipedrivemail.com"
              }
            },
            person: {
              "7": {
                id: 7,
                name: "me",
                email: [{ value: "", primary: true }],
                phone: [{value: "", primary: true }]
              }
            }
          }
        }
      )
    end
  end
end
