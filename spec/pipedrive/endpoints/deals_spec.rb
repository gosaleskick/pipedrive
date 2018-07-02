# frozen_string_literal: true

require 'spec_helper'

describe Pipedrive::Endpoints::Deals do
  let(:token) { TokenAR.new }
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

  describe 'GET /deals/timeline' do
    subject { client.deals_timeline(params) }

    context 'valid params' do
      let(:params) { { user_id: 5323730, start_date: '2018-06-19', interval: 'day', amount: 2, field_key: 'add_time' } }

      it 'returns result object with json response', :vcr do
        expect(subject).to be_a(Pipedrive::Result)
        expect(subject.data).to match({
          success: true,
          data: [
            {
              period_start: "2018-06-19 00:00:00",
              period_end: "2018-06-19 23:59:59",
              deals: [],
              totals: {
                count: 0,
                values: [],
                weighted_values: [],
                open_count: 0,
                open_values: [],
                weighted_open_values: [],
                won_count: 0,
                won_values: []
              }
            }, {
              period_start: "2018-06-20 00:00:00",
              period_end: "2018-06-20 23:59:59",
              deals: [
                {
                  id: 8,
                  creator_user_id: 5323730,
                  user_id: 5323730,
                  person_id: nil,
                  org_id: 9,
                  stage_id: 1,
                  title: "sales deal",
                  value: 22,
                  currency: "USD",
                  add_time: "2018-06-20 08:59:22",
                  update_time: "2018-06-20 09:37:22",
                  stage_change_time: nil,
                  active: false,
                  deleted: false,
                  status: "won",
                  probability: nil,
                  next_activity_date: nil,
                  next_activity_time: nil,
                  next_activity_id: nil,
                  last_activity_id: nil,
                  last_activity_date: nil,
                  lost_reason: nil,
                  visible_to: "3",
                  close_time: "2018-06-20 09:37:21",
                  pipeline_id: 1,
                  won_time: "2018-06-20 09:37:21",
                  first_won_time: "2018-06-20 09:37:21",
                  lost_time: nil,
                  products_count: 0,
                  files_count: 0,
                  notes_count: 0,
                  followers_count: 1,
                  email_messages_count: 0,
                  activities_count: 0,
                  done_activities_count: 0,
                  undone_activities_count: 0,
                  reference_activities_count: 0,
                  participants_count: 0,
                  expected_close_date: nil,
                  last_incoming_mail_time: nil,
                  last_outgoing_mail_time: nil,
                  stage_order_nr: 1,
                  person_name: nil,
                  org_name: "sales",
                  next_activity_subject: nil,
                  next_activity_type: nil,
                  next_activity_duration: nil,
                  next_activity_note: nil,
                  formatted_value: "$22",
                  weighted_value: 22,
                  formatted_weighted_value: "$22",
                  weighted_value_currency: "USD",
                  rotten_time: nil,
                  owner_name: "Adam Zapaśnik",
                  cc_email: "adamzapasnik-sandbox+deal8@pipedrivemail.com",
                  org_hidden: false,
                  person_hidden: false
                }, {
                  id: 9,
                  creator_user_id: 5323730,
                  user_id: 5323730,
                  person_id: nil,
                  org_id: 10,
                  stage_id: 3,
                  title: "sakee deal",
                  value: 111,
                  currency: "USD",
                  add_time: "2018-06-20 08:59:44",
                  update_time: "2018-06-20 08:59:45",
                  stage_change_time: nil,
                  active: true,
                  deleted: false,
                  status: "open",
                  probability: nil,
                  next_activity_date: nil,
                  next_activity_time: nil,
                  next_activity_id: nil,
                  last_activity_id: nil,
                  last_activity_date: nil,
                  lost_reason: nil,
                  visible_to: "3",
                  close_time: nil,
                  pipeline_id: 1,
                  won_time: nil,
                  first_won_time: nil,
                  lost_time: nil,
                  products_count: 0,
                  files_count: 0,
                  notes_count: 0,
                  followers_count: 1,
                  email_messages_count: 0,
                  activities_count: 0,
                  done_activities_count: 0,
                  undone_activities_count: 0,
                  reference_activities_count: 0,
                  participants_count: 0,
                  expected_close_date: nil,
                  last_incoming_mail_time: nil,
                  last_outgoing_mail_time: nil,
                  stage_order_nr: 3,
                  person_name: nil,
                  org_name: "sakee",
                  next_activity_subject: nil,
                  next_activity_type: nil,
                  next_activity_duration: nil,
                  next_activity_note: nil,
                  formatted_value: "$111",
                  weighted_value: 111,
                  formatted_weighted_value: "$111",
                  weighted_value_currency: "USD",
                  rotten_time: nil,
                  owner_name: "Adam Zapaśnik",
                  cc_email: "adamzapasnik-sandbox+deal9@pipedrivemail.com",
                  org_hidden: false,
                  person_hidden: false
                }
              ],
              totals: {
                count: 2,
                values: { USD: 133 },
                weighted_values: { USD: 133 },
                open_count: 1,
                open_values: { USD: 111 },
                weighted_open_values: { USD: 111 },
                won_count: 1,
                won_values: { USD: 22 }
              }
            }
          ],
        })
      end
    end

    context 'invalid_params' do
      context 'start_date missing' do
        let(:params) { {} }

        it 'raises an error' do
          expect { subject }.to raise_error Pipedrive::Connection::MissingParameter
        end
      end

      context 'interval missing' do
        let(:params) { { start_date: '2018-02-14' } }

        it 'raises an error' do
          expect { subject }.to raise_error Pipedrive::Connection::MissingParameter
        end
      end

      context 'amount missing' do
        let(:params) { { start_date: '2018-02-14', interval: 1 } }

        it 'raises an error' do
          expect { subject }.to raise_error Pipedrive::Connection::MissingParameter
        end
      end

      context 'field_key missing' do
        let(:params) { { start_date: '2018-02-14', interval: 1, amount: 2 } }

        it 'raises an error' do
          expect { subject }.to raise_error Pipedrive::Connection::MissingParameter
        end
      end
    end
  end
end
