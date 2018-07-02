# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::Endpoints::Activities do
  let(:token) { TokenAR.new }
  let(:client) { Pipedrive::OAuth::Client.new(token: token) }

  describe 'GET /activities' do
    it 'returns result object with json response' do
      VCR.use_cassette('activities') do
        result = client.activities

        expect(result).to be_a(Pipedrive::Result)
        expect(result.data).to match(
          {
            success: true,
            data: [
              {
                id: 1,
                company_id: 3408256,
                user_id: 5206648,
                done: false,
                type: "call",
                reference_type: "none",
                reference_id: nil,
                due_date: "2018-06-12",
                due_time: "",
                duration: "",
                add_time: "2018-06-07 08:46:06",
                marked_as_done_time: "",
                last_notification_time: nil,
                last_notification_user_id: nil,
                notification_language_id: 1,
                subject: "Call",
                org_id: 2,
                person_id: 2,
                deal_id: 2,
                active_flag: true,
                update_time: "2018-06-07 08:46:06",
                update_user_id: nil,
                gcal_event_id: nil,
                google_calendar_id: nil,
                google_calendar_etag: nil,
                note: "",
                created_by_user_id: 5206648,
                participants: [{ person_id: 2, primary_flag: true }],
                org_name: "Apple",
                person_name: "Steve Jobs",
                deal_title: "Apple deal",
                owner_name: "Matt Kozak",
                person_dropbox_bcc: "saleskick-sandbox@pipedrivemail.com",
                deal_dropbox_bcc: "saleskick-sandbox+deal2@pipedrivemail.com",
                assigned_to_user_id: 5206648
              }
            ],
            additional_data: {
              pagination: {
                start: 0,
                limit: 500,
                more_items_in_collection: false
              }
            },
            related_objects: {
              user: {
                '5206648': {
                  id: 5206648,
                  name: "Matt Kozak",
                  email: "matt@saleskick.co",
                  has_pic: true,
                  pic_hash: "6d20d82bb568e1a91144032018ca0f5f",
                  active_flag: true
                }
              },
              person: {
                '2': {
                  id: 2,
                  name: "Steve Jobs",
                  email: [
                    {value: "", primary: true}
                  ],
                  phone: [
                    {value: "", primary: true}
                  ]
                }
              },
              organization: {
                '2': {
                  id: 2,
                  name: "Apple",
                  people_count: 1,
                  owner_id: 5206648,
                  address: nil,
                  cc_email: "saleskick-sandbox@pipedrivemail.com"
                }
              },
              deal: {
                '2': {
                  id: 2,
                  title: "Apple deal",
                  status: "open",
                  value: 1000000,
                  currency: "USD",
                  stage_id: 3,
                  pipeline_id: 1
                }
              }
            }
          }
        )
      end
    end

    it 'returns result object with ability to query more data' do
      VCR.use_cassette('more_activities') do
        result = client.activities(limit: 1)
        more_items_result = result.more_items

        expect(result).to be_a(Pipedrive::Result)
        expect(more_items_result).to be_a(Pipedrive::Result)
        expect(more_items_result.data).to match(
          {
            success: true,
            data: [
              {
                id: 2,
                company_id: 3408256,
                user_id: 5206648,
                done: false,
                type: "task",
                reference_type: "none",
                reference_id: nil,
                due_date: "2018-06-19",
                due_time: "",
                duration: "",
                add_time: "2018-06-07 10:13:33",
                marked_as_done_time: "",
                last_notification_time: nil,
                last_notification_user_id: nil,
                notification_language_id: 1,
                subject: "Task",
                org_id: 3,
                person_id: 3,
                deal_id: 3,
                active_flag: true,
                update_time: "2018-06-07 10:13:33",
                update_user_id: nil,
                gcal_event_id: nil,
                google_calendar_id: nil,
                google_calendar_etag: nil,
                note: "",
                created_by_user_id: 5206648,
                participants: [
                  {
                    person_id: 3,
                    primary_flag: true
                  }
                ],
                org_name: "Microsoft",
                person_name: "Satya Nadela",
                deal_title: "Microsoft deal",
                owner_name: "Matt Kozak",
                person_dropbox_bcc: "saleskick-sandbox@pipedrivemail.com",
                deal_dropbox_bcc: "saleskick-sandbox+deal3@pipedrivemail.com",
                assigned_to_user_id: 5206648
              }
            ],
            additional_data: {
              pagination: {
                start: 1,
                limit: 1,
                more_items_in_collection: false
                }
              },
            related_objects: {
              user: {
                '5206648': {
                  id: 5206648,
                  name: "Matt Kozak",
                  email: "matt@saleskick.co",
                  has_pic: true,
                  pic_hash: "6d20d82bb568e1a91144032018ca0f5f",
                  active_flag: true
                }
              },
              person: {
                '3': {
                  id: 3,
                  name: "Satya Nadela",
                  email: [{value: "",primary: true}],
                  phone: [{value: "",primary: true}]
                }
              },
              organization: {
                '3': {
                  id: 3,
                  name: "Microsoft",
                  people_count: 1,
                  owner_id: 5206648,
                  address: nil,
                  cc_email: "saleskick-sandbox@pipedrivemail.com"
                }
              },
              deal: {
                '3': {
                  id: 3,
                  title: "Microsoft deal",
                  status: "open",
                  value: 100000,
                  currency: "USD",
                  stage_id: 6,
                  pipeline_id: 1
                }
              }
            }
          }
        )
      end
    end
  end
end
