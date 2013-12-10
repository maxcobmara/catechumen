# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130905000000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "academic_sessions", force: true do |t|
    t.string   "semester"
    t.integer  "total_week"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accessions", force: true do |t|
    t.integer  "book_id"
    t.string   "accession_no"
    t.string   "order_no"
    t.decimal  "purchase_price"
    t.date     "received"
    t.integer  "received_by"
    t.integer  "supplied_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addbooks", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "mail"
    t.string   "web"
    t.string   "fax"
    t.string   "shortname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "address_book_items", force: true do |t|
    t.integer  "address_book_id"
    t.string   "item"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addsuppliers", force: true do |t|
    t.integer  "supplier_id"
    t.string   "lpono"
    t.string   "document"
    t.decimal  "quantity"
    t.decimal  "unitcost"
    t.date     "received"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answerchoices", force: true do |t|
    t.integer  "examquestion_id"
    t.string   "item"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appraisals", force: true do |t|
    t.integer  "staff_id"
    t.date     "evaldt"
    t.date     "parttwodt"
    t.decimal  "pppquantity"
    t.decimal  "ppkquantity"
    t.decimal  "pppquality"
    t.decimal  "ppkquality"
    t.decimal  "pppontime"
    t.decimal  "ppkontime"
    t.decimal  "pppeffective"
    t.decimal  "ppkeffective"
    t.decimal  "pppknowledge"
    t.decimal  "ppkknowledge"
    t.decimal  "ppprules"
    t.decimal  "ppkrules"
    t.decimal  "pppcommunication"
    t.decimal  "ppkcommunication"
    t.decimal  "pppleader"
    t.decimal  "ppkleader"
    t.decimal  "pppmanage"
    t.decimal  "ppkmanage"
    t.decimal  "pppdiscipline"
    t.decimal  "ppkdisipline"
    t.decimal  "pppproactive"
    t.decimal  "ppkproactive"
    t.decimal  "ppprelate"
    t.decimal  "ppkrelate"
    t.decimal  "pppparttwo"
    t.decimal  "ppkparttwo"
    t.decimal  "ppptotals"
    t.decimal  "ppktotals"
    t.decimal  "ppppercent"
    t.decimal  "ppkpercent"
    t.decimal  "pointsaverage"
    t.integer  "pppyears"
    t.integer  "pppmonths"
    t.text     "pppoverall"
    t.text     "pppadvancemet"
    t.integer  "ppp_id"
    t.date     "pppevaldt"
    t.integer  "ppkyears"
    t.integer  "ppkmonths"
    t.text     "ppkoverall"
    t.integer  "ppk_id"
    t.date     "ppkevaldt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_defects", force: true do |t|
    t.integer  "asset_id"
    t.integer  "reported_by"
    t.text     "notes"
    t.text     "description"
    t.string   "process_type"
    t.text     "recommendation"
    t.boolean  "is_processed"
    t.integer  "processed_by"
    t.date     "processed_on"
    t.boolean  "decision"
    t.integer  "decision_by"
    t.date     "decision_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_disposals", force: true do |t|
    t.integer  "asset_id"
    t.integer  "quantity"
    t.integer  "asset_defect_id"
    t.text     "description"
    t.integer  "running_hours"
    t.integer  "mileage"
    t.string   "current_condition"
    t.decimal  "current_value"
    t.decimal  "est_repair_cost"
    t.decimal  "est_value_post_repair"
    t.decimal  "est_time_next_fail"
    t.string   "repair1_needed"
    t.string   "repair2_needed"
    t.string   "repair3_needed"
    t.string   "justify1_disposal"
    t.string   "justify2_disposal"
    t.string   "justify3_disposal"
    t.boolean  "is_checked"
    t.date     "checked_on"
    t.boolean  "is_verified"
    t.date     "verified_on"
    t.decimal  "revalue"
    t.integer  "revalued_by"
    t.date     "revalued_on"
    t.integer  "document_id"
    t.string   "disposal_type"
    t.string   "type_others_desc"
    t.string   "discard_options"
    t.string   "receiver_name"
    t.string   "documentation_no"
    t.boolean  "is_disposed"
    t.integer  "inform_hod"
    t.integer  "disposed_by"
    t.date     "disposed_on"
    t.boolean  "is_discarded"
    t.date     "discarded_on"
    t.string   "discard_location"
    t.integer  "discard_witness_1"
    t.integer  "discard_witness_2"
    t.integer  "checked_by"
    t.integer  "verified_by"
    t.string   "examiner1"
    t.string   "examiner2"
    t.boolean  "is_staff1"
    t.boolean  "is_staff2"
    t.integer  "examiner_staff1"
    t.integer  "examiner_staff2"
    t.string   "witness_outsider1"
    t.string   "witness_outsider2"
    t.boolean  "witness_is_staff1"
    t.boolean  "witness_is_staff2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_loans", force: true do |t|
    t.integer  "asset_id"
    t.integer  "staff_id"
    t.text     "reasons"
    t.integer  "loaned_by"
    t.boolean  "is_approved"
    t.date     "approved_date"
    t.date     "loaned_on"
    t.date     "expected_on"
    t.boolean  "is_returned"
    t.date     "returned_on"
    t.text     "remarks"
    t.integer  "loan_officer"
    t.integer  "hod"
    t.date     "hod_date"
    t.integer  "loantype"
    t.integer  "received_officer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_losses", force: true do |t|
    t.boolean  "form_type"
    t.string   "loss_type"
    t.integer  "asset_id"
    t.string   "cash_type"
    t.decimal  "est_value"
    t.boolean  "is_used"
    t.string   "ownership"
    t.decimal  "value_state"
    t.decimal  "value_federal"
    t.integer  "location_id"
    t.datetime "lost_at"
    t.text     "how_desc"
    t.string   "report_code"
    t.integer  "last_handled_by"
    t.boolean  "is_prima_facie"
    t.boolean  "is_staff_action"
    t.boolean  "is_police_report_made"
    t.string   "police_report_code"
    t.text     "why_no_report"
    t.text     "police_action_status"
    t.boolean  "is_rule_broken"
    t.text     "rules_broken_desc"
    t.text     "preventive_action_dept"
    t.integer  "prev_action_enforced_by"
    t.text     "preventive_measures"
    t.text     "new_measures"
    t.text     "recommendations"
    t.text     "surcharge_notes"
    t.text     "notes"
    t.integer  "investigated_by"
    t.string   "investigation_code"
    t.date     "investigation_completed_on"
    t.text     "security_officer_notes"
    t.integer  "security_officer_id"
    t.string   "security_code"
    t.boolean  "is_submit_to_hod"
    t.integer  "endorsed_hod_by"
    t.date     "endorsed_on"
    t.boolean  "is_writeoff"
    t.integer  "document_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "asset_placements", force: true do |t|
    t.integer  "asset_id"
    t.integer  "location_id"
    t.integer  "staff_id"
    t.date     "reg_on"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assetcategories", force: true do |t|
    t.integer  "parent_id"
    t.string   "description"
    t.integer  "cattype_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assetlosses", force: true do |t|
    t.string   "losstype"
    t.decimal  "estvalue"
    t.integer  "asset_id"
    t.integer  "part_id"
    t.integer  "losslocation_id"
    t.datetime "lossdt"
    t.string   "losshow"
    t.integer  "lossstafflast_id"
    t.boolean  "laststaffcase"
    t.boolean  "laststaffstop"
    t.boolean  "poreport"
    t.string   "porepno"
    t.string   "poaction"
    t.string   "ponoreportwhy"
    t.string   "preventpast"
    t.string   "preventfuture"
    t.string   "remarks"
    t.integer  "hod_id"
    t.date     "hodendorsedt"
    t.string   "moneytype"
    t.boolean  "new"
    t.string   "reportcode"
    t.integer  "so_id"
    t.boolean  "sostop"
    t.date     "sostopdt"
    t.string   "soaction"
    t.boolean  "ownerstop"
    t.date     "ownerstopdt"
    t.string   "owneraction"
    t.boolean  "supstop"
    t.date     "supstopdt"
    t.string   "supaction"
    t.boolean  "rulesbroken"
    t.string   "newrule"
    t.integer  "newrule_id"
    t.string   "nrrecommend"
    t.boolean  "surcharge"
    t.decimal  "scvalue"
    t.string   "screason"
    t.integer  "sio_id"
    t.integer  "ssecurity_id"
    t.date     "closedt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assetnums", force: true do |t|
    t.integer  "asset_id"
    t.string   "assetnumname"
    t.string   "assetadnum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", force: true do |t|
    t.string   "assetcode"
    t.string   "cardno"
    t.integer  "assettype"
    t.boolean  "bookable"
    t.string   "name"
    t.string   "typename"
    t.integer  "manufacturer_id"
    t.string   "modelname"
    t.string   "serialno"
    t.text     "otherinfo"
    t.string   "orderno"
    t.decimal  "purchaseprice"
    t.date     "purchasedate"
    t.date     "receiveddate"
    t.integer  "receiver_id"
    t.integer  "supplier_id"
    t.integer  "assignedto_id"
    t.boolean  "locassigned"
    t.integer  "status"
    t.integer  "location_id"
    t.integer  "country_id"
    t.integer  "warranty_length"
    t.integer  "warranty_length_type"
    t.integer  "category_id"
    t.string   "subcategory"
    t.integer  "quantity"
    t.string   "quantity_type"
    t.integer  "engine_type_id"
    t.string   "engine_no"
    t.string   "registration"
    t.string   "nationcode"
    t.boolean  "mark_disposal"
    t.boolean  "mark_as_lost"
    t.boolean  "is_disposed"
    t.boolean  "is_maintainable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assetsearches", force: true do |t|
    t.string   "assetcode"
    t.integer  "assettype"
    t.string   "name"
    t.decimal  "purchaseprice"
    t.date     "purchasedate"
    t.date     "startdate"
    t.date     "enddate"
    t.integer  "category"
    t.integer  "assignedto"
    t.boolean  "bookable"
    t.date     "loandate"
    t.date     "returndate"
    t.integer  "location"
    t.integer  "defect_asset"
    t.integer  "defect_reporter"
    t.integer  "defect_processor"
    t.string   "defect_process"
    t.boolean  "maintainable"
    t.string   "maintname"
    t.string   "maintcode"
    t.integer  "disposal"
    t.string   "disposaltype"
    t.string   "discardoption"
    t.string   "disposalreport"
    t.integer  "disposalcert"
    t.string   "disposalreport2"
    t.integer  "loss_start"
    t.integer  "loss_end"
    t.integer  "loss_cert"
    t.integer  "loanedasset"
    t.integer  "alldefectasset"
    t.decimal  "purchaseprice2"
    t.date     "purchasedate2"
    t.date     "receiveddate"
    t.date     "receiveddate2"
    t.date     "loandate2"
    t.date     "returndate2"
    t.date     "expectedreturndate"
    t.date     "expectedreturndate2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assettracks", force: true do |t|
    t.integer  "asset_id"
    t.integer  "staff_id"
    t.date     "reservationdate"
    t.date     "use_startdate"
    t.date     "use_enddate"
    t.integer  "issuedby"
    t.date     "issuedate"
    t.date     "expectedreturndate"
    t.integer  "returnedto"
    t.date     "actualreturndate"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", force: true do |t|
    t.integer  "staff_id"
    t.date     "attdate"
    t.time     "time_in"
    t.time     "time_out"
    t.string   "reason"
    t.integer  "approve_id"
    t.boolean  "approvestatus"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bankaccounts", force: true do |t|
    t.integer  "staff_id"
    t.integer  "student_id"
    t.integer  "bank_id"
    t.string   "account_no"
    t.integer  "account_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banks", force: true do |t|
    t.string   "short_name"
    t.string   "long_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "active"
  end

  create_table "books", force: true do |t|
    t.string   "tagno"
    t.string   "controlno"
    t.string   "isbn"
    t.string   "bookcode"
    t.string   "accessionno"
    t.string   "catsource"
    t.string   "classlcc"
    t.string   "classddc"
    t.string   "title"
    t.string   "author"
    t.string   "publisher"
    t.string   "description"
    t.integer  "loantype"
    t.integer  "mediatype"
    t.integer  "status"
    t.string   "series"
    t.string   "location"
    t.string   "topic"
    t.string   "orderno"
    t.decimal  "purchaseprice"
    t.date     "purchasedate"
    t.date     "receiveddate"
    t.integer  "receiver_id"
    t.integer  "supplier_id"
    t.string   "issn"
    t.string   "edition"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "publish_date"
    t.string   "publish_location"
    t.string   "language"
    t.text     "links"
    t.text     "subject"
    t.integer  "quantity"
    t.string   "roman"
    t.string   "size"
    t.string   "pages"
    t.string   "bibliography"
    t.string   "indice"
    t.string   "notes"
    t.string   "backuproman"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "booksearches", force: true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "isbn"
    t.string   "accessionno"
    t.string   "classno"
    t.string   "accessionno_start"
    t.string   "accessionno_end"
    t.integer  "stock_summary"
    t.integer  "accumbookloan"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "booleananswers", force: true do |t|
    t.integer  "examquestion_id"
    t.string   "item"
    t.boolean  "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "booleanchoices", force: true do |t|
    t.integer  "examquestion_id"
    t.string   "item"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bulletins", force: true do |t|
    t.string   "headline"
    t.text     "content"
    t.integer  "postedby_id"
    t.date     "publishdt"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cofiles", force: true do |t|
    t.string   "cofileno"
    t.string   "name"
    t.string   "location"
    t.integer  "owner_id"
    t.boolean  "onloan"
    t.integer  "staffloan_id"
    t.date     "onloandt"
    t.date     "onloanxdt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "counsellings", force: true do |t|
    t.integer  "student_id"
    t.integer  "cofile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "curriculumsearches", force: true do |t|
    t.integer  "programme_id"
    t.integer  "semester"
    t.integer  "subject"
    t.integer  "topic"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disposals", force: true do |t|
    t.integer  "asset_id"
    t.boolean  "used"
    t.string   "usedduration"
    t.decimal  "currentvalue"
    t.string   "opinion"
    t.string   "recommendation"
    t.boolean  "gift"
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "serialno"
    t.string   "refno"
    t.integer  "category"
    t.string   "title"
    t.date     "letterdt"
    t.date     "letterxdt"
    t.string   "from"
    t.integer  "stafffiled_id"
    t.integer  "file_id"
    t.boolean  "closed"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.text     "otherinfo"
    t.integer  "cctype_id"
    t.integer  "cc1staff_id"
    t.date     "cc1date"
    t.string   "cc1action"
    t.text     "cc1remarks"
    t.boolean  "cc1closed"
    t.integer  "cc2staff_id"
    t.date     "cc2date"
    t.string   "cc2action"
    t.text     "cc2remarks"
    t.boolean  "cc2closed"
    t.date     "cc1actiondate"
    t.string   "dataaction_file_name"
    t.string   "dataaction_content_type"
    t.integer  "dataaction_file_size"
    t.datetime "dataaction_updated_at"
    t.integer  "prepared_by"
    t.string   "sender"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents_staffs", id: false, force: true do |t|
    t.integer "document_id"
    t.integer "staff_id"
  end

  create_table "documentsearches", force: true do |t|
    t.string   "refno"
    t.integer  "category"
    t.string   "title"
    t.date     "letterdt"
    t.date     "letterxdt"
    t.string   "from"
    t.integer  "file_id"
    t.boolean  "closed"
    t.string   "sender"
    t.date     "letterdtend"
    t.date     "letterxdtend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employgrades", force: true do |t|
    t.string   "name"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evactivities", force: true do |t|
    t.integer  "appraisal_id"
    t.date     "evaldt"
    t.string   "evactivity"
    t.string   "actlevel"
    t.date     "actdt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "eventname"
    t.string   "location"
    t.text     "participants"
    t.string   "officiated"
    t.datetime "start_at"
    t.datetime "end_at"
    t.integer  "createdby"
    t.boolean  "event_is_publik"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examanalyses", force: true do |t|
    t.integer  "exam_id"
    t.integer  "gradeA"
    t.integer  "gradeAminus"
    t.integer  "gradeBplus"
    t.integer  "gradeB"
    t.integer  "gradeBminus"
    t.integer  "gradeCplus"
    t.integer  "gradeC"
    t.integer  "gradeCminus"
    t.integer  "gradeDplus"
    t.integer  "gradeD"
    t.integer  "gradeE"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examanalysissearches", force: true do |t|
    t.string   "examtype"
    t.integer  "subject_id"
    t.date     "examon"
    t.integer  "exampaper"
    t.integer  "programme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examanswers", force: true do |t|
    t.integer  "examquestion_id"
    t.string   "item"
    t.string   "answer_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exammakers", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exammakers_examquestions", id: false, force: true do |t|
    t.integer  "exammaker_id"
    t.integer  "examquestion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exammarks", force: true do |t|
    t.integer  "student_id"
    t.integer  "exam_id"
    t.decimal  "total_mcq"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exammcqanswers", force: true do |t|
    t.integer  "examquestion_id"
    t.string   "sequence"
    t.string   "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examquestionanalyses", force: true do |t|
    t.integer  "examquestion_id"
    t.integer  "count"
    t.decimal  "min"
    t.decimal  "max"
    t.decimal  "mean"
    t.decimal  "sd_population"
    t.integer  "pass_rate"
    t.decimal  "pass_percentage"
    t.integer  "mark0"
    t.integer  "markless20"
    t.integer  "markless50"
    t.integer  "markless80"
    t.integer  "markmore80"
    t.integer  "examanalysis_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examquestions", force: true do |t|
    t.integer  "subject_id"
    t.string   "questiontype"
    t.text     "question"
    t.text     "answer"
    t.decimal  "marks"
    t.string   "category"
    t.string   "qkeyword"
    t.string   "qstatus"
    t.integer  "creator_id"
    t.date     "createdt"
    t.string   "difficulty"
    t.text     "statusremark"
    t.integer  "editor_id"
    t.date     "editdt"
    t.integer  "approver_id"
    t.date     "approvedt"
    t.boolean  "bplreserve"
    t.boolean  "bplsent"
    t.date     "bplsentdt"
    t.string   "diagram_file_name"
    t.string   "diagram_content_type"
    t.integer  "diagram_file_size"
    t.datetime "diagram_updated_at"
    t.integer  "topic_id"
    t.string   "construct"
    t.boolean  "conform_curriculum"
    t.boolean  "conform_specification"
    t.boolean  "conform_opportunity"
    t.boolean  "accuracy_construct"
    t.boolean  "accuracy_topic"
    t.boolean  "accuracy_component"
    t.boolean  "fit_difficulty"
    t.boolean  "fit_important"
    t.boolean  "fit_fairness"
    t.integer  "programme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examquestions_exams", id: false, force: true do |t|
    t.integer  "exam_id"
    t.integer  "examquestion_id"
    t.integer  "sequence"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examresults", force: true do |t|
    t.integer  "programme_id"
    t.decimal  "total"
    t.decimal  "pngs17"
    t.string   "status"
    t.string   "remark"
    t.string   "semester"
    t.date     "examdts"
    t.date     "examdte"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examresults_students", id: false, force: true do |t|
    t.integer "examresult_id"
    t.integer "student_id"
  end

  create_table "examresultsearches", force: true do |t|
    t.integer  "programme_id"
    t.integer  "subject_id"
    t.integer  "student_id"
    t.string   "semester"
    t.date     "examdts"
    t.date     "examdte"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exams", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "created_by"
    t.integer  "course_id"
    t.integer  "subject_id"
    t.integer  "klass_id"
    t.date     "exam_on"
    t.integer  "duration"
    t.integer  "full_marks"
    t.time     "starttime"
    t.time     "endtime"
    t.integer  "topic_id"
    t.string   "sequ"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examsearches", force: true do |t|
    t.integer  "programme_id"
    t.integer  "subject_id"
    t.string   "examtype"
    t.integer  "created_by"
    t.integer  "klass_id"
    t.date     "examdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examsubquestions", force: true do |t|
    t.integer  "examquestion_id"
    t.integer  "parent_id"
    t.string   "sequence"
    t.string   "question"
    t.string   "classification"
    t.integer  "marks"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "examtemplates", force: true do |t|
    t.integer  "quantity"
    t.integer  "exam_id"
    t.decimal  "total_marks"
    t.string   "questiontype"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: true do |t|
    t.integer  "student_id"
    t.integer  "subject_id"
    t.boolean  "sent_to_BPL"
    t.date     "sent_date"
    t.decimal  "formative"
    t.decimal  "score"
    t.boolean  "eligible_for_exam"
    t.boolean  "carry_paper"
    t.decimal  "summative"
    t.boolean  "resit"
    t.decimal  "finalscore"
    t.integer  "grading_id"
    t.string   "exam1name"
    t.string   "exam1desc"
    t.decimal  "exam1marks"
    t.string   "exam2name"
    t.string   "exam2desc"
    t.decimal  "exam2marks"
    t.decimal  "examweight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "intakes", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "register_on"
    t.integer  "programme_id"
    t.boolean  "is_active"
    t.date     "monthyear_intake"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kins", force: true do |t|
    t.integer  "kintype_id"
    t.integer  "staff_id"
    t.integer  "student_id"
    t.string   "name"
    t.date     "kinbirthdt"
    t.string   "phone"
    t.string   "kinaddr"
    t.string   "profession"
    t.string   "mykadno"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses", force: true do |t|
    t.string   "name"
    t.integer  "intake_id"
    t.integer  "programme_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses_students", id: false, force: true do |t|
    t.integer "klass_id"
    t.integer "student_id"
  end

  create_table "leaveforstaffs", force: true do |t|
    t.integer  "staff_id"
    t.integer  "leavetype"
    t.date     "leavestartdate"
    t.date     "leavenddate"
    t.decimal  "leavedays"
    t.string   "reason"
    t.text     "notes"
    t.integer  "replacement_id"
    t.boolean  "submit"
    t.boolean  "approval1"
    t.integer  "approval1_id"
    t.date     "approval1date"
    t.boolean  "approver2"
    t.integer  "approval2_id"
    t.date     "approval2date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaveforstudents", force: true do |t|
    t.integer  "student_id"
    t.string   "leavetype"
    t.date     "requestdate"
    t.string   "reason"
    t.string   "address"
    t.string   "telno"
    t.date     "leave_startdate"
    t.date     "leave_enddate"
    t.boolean  "studentsubmit"
    t.boolean  "approved"
    t.integer  "staff_id"
    t.date     "approvedate"
    t.text     "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_plan_trainingnotes", force: true do |t|
    t.integer  "lesson_plan_id"
    t.integer  "trainingnote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lesson_plans", force: true do |t|
    t.integer  "lecturer"
    t.integer  "intake_id"
    t.integer  "student_qty"
    t.integer  "semester"
    t.integer  "topic"
    t.string   "lecture_title"
    t.date     "lecture_date"
    t.time     "start_time"
    t.time     "end_time"
    t.text     "reference"
    t.boolean  "is_submitted"
    t.date     "submitted_on"
    t.boolean  "hod_approved"
    t.date     "hod_approved_on"
    t.boolean  "hod_rejected"
    t.date     "hod_rejected_on"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_ot"
    t.string   "prerequisites"
    t.integer  "year"
    t.text     "reason"
    t.integer  "prepared_by"
    t.integer  "endorsed_by"
    t.boolean  "condition_isgood"
    t.boolean  "condition_isnotgood"
    t.string   "condition_desc"
    t.text     "training_aids"
    t.text     "summary"
    t.integer  "total_absent"
    t.boolean  "report_submit"
    t.date     "report_submit_on"
    t.boolean  "report_endorsed"
    t.date     "report_endorsed_on"
    t.text     "report_summary"
    t.integer  "schedule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessonplan_methodologies", force: true do |t|
    t.text     "content"
    t.text     "lecturer_activity"
    t.text     "student_activity"
    t.text     "training_aids"
    t.text     "evaluation"
    t.integer  "lesson_plan_id"
    t.time     "start_meth"
    t.time     "end_meth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessonplansearches", force: true do |t|
    t.integer  "lecturer"
    t.integer  "intake_id"
    t.integer  "programme_id"
    t.integer  "intake"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "librarytransactions", force: true do |t|
    t.integer  "accession_id"
    t.boolean  "ru_staff"
    t.integer  "staff_id"
    t.integer  "student_id"
    t.date     "checkoutdate"
    t.date     "returnduedate"
    t.boolean  "extended"
    t.boolean  "returned"
    t.date     "returneddate"
    t.decimal  "fine"
    t.boolean  "finepay"
    t.date     "finepaydate"
    t.boolean  "reportlost"
    t.text     "report"
    t.date     "reportlostdate"
    t.date     "replaceddate"
    t.integer  "libcheckout_by"
    t.integer  "libextended_by"
    t.integer  "libreturned_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "librarytransactionsearches", force: true do |t|
    t.integer  "accumbookloan"
    t.integer  "programme"
    t.integer  "fines"
    t.integer  "bookloans"
    t.date     "yearstat"
    t.integer  "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", force: true do |t|
    t.integer  "staff_id"
    t.integer  "ltype"
    t.string   "accno"
    t.date     "startdt"
    t.integer  "durationmn"
    t.decimal  "deductions"
    t.decimal  "amount"
    t.date     "firstdate"
    t.date     "enddate"
    t.decimal  "enddeduction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "lclass"
    t.integer  "typename"
    t.boolean  "allocatable"
    t.boolean  "occupied"
    t.integer  "staffadmin_id"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maints", force: true do |t|
    t.integer  "asset_id"
    t.integer  "maintainer_id"
    t.string   "workorderno"
    t.decimal  "maintcost"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marks", force: true do |t|
    t.integer  "exammark_id"
    t.decimal  "student_mark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages_staffs", id: false, force: true do |t|
    t.integer "message_id"
    t.integer "staff_id"
  end

  create_table "pages", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.boolean  "admin"
    t.integer  "parent_id"
    t.string   "navlabel"
    t.integer  "position"
    t.boolean  "redirect"
    t.string   "action_name"
    t.string   "controller_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parts", force: true do |t|
    t.string   "partcode"
    t.string   "category"
    t.string   "unittype"
    t.decimal  "quantity"
    t.decimal  "maxquantity"
    t.decimal  "minquantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "personalizetimetablesearches", force: true do |t|
    t.integer  "lecturer"
    t.integer  "programme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", force: true do |t|
    t.string   "code"
    t.string   "combo_code"
    t.string   "name"
    t.string   "unit"
    t.text     "tasks_main"
    t.text     "tasks_other"
    t.integer  "staffgrade_id"
    t.integer  "staff_id"
    t.boolean  "is_acting"
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programmes", force: true do |t|
    t.string   "code"
    t.string   "combo_code"
    t.string   "name"
    t.string   "course_type"
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.text     "objective"
    t.integer  "duration"
    t.integer  "duration_type"
    t.integer  "credits"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programmes_subjects", id: false, force: true do |t|
    t.integer "programme_id"
    t.integer "subject_id"
  end

  create_table "ptbudgets", force: true do |t|
    t.decimal  "budget"
    t.date     "fiscalstart"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ptcourses", force: true do |t|
    t.string   "name"
    t.integer  "course_type"
    t.integer  "provider_id"
    t.decimal  "duration"
    t.integer  "duration_type"
    t.string   "proponent"
    t.decimal  "cost"
    t.text     "description"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ptdos", force: true do |t|
    t.integer  "ptcourse_id"
    t.integer  "ptschedule_id"
    t.integer  "staff_id"
    t.string   "justification"
    t.string   "unit_review"
    t.boolean  "unit_approve"
    t.string   "dept_review"
    t.boolean  "dept_approve"
    t.integer  "replacement_id"
    t.boolean  "final_approve"
    t.text     "trainee_report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ptschedules", force: true do |t|
    t.integer  "ptcourse_id"
    t.date     "start"
    t.string   "location"
    t.integer  "min_participants"
    t.integer  "max_participants"
    t.decimal  "final_price"
    t.boolean  "budget_ok"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qualifications", force: true do |t|
    t.integer  "staff_id"
    t.integer  "student_id"
    t.integer  "level_id"
    t.string   "qname"
    t.integer  "institute_id"
    t.string   "institute"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residences", force: true do |t|
    t.string   "rescode"
    t.string   "resname"
    t.integer  "parent_id"
    t.integer  "resclass"
    t.integer  "restype"
    t.boolean  "allocatable"
    t.integer  "staff_id"
    t.integer  "student_id"
    t.date     "keytxdt"
    t.date     "keyreturndt"
    t.date     "keyexpectdate"
    t.boolean  "keyrx"
    t.integer  "staffadmin_id"
    t.string   "ancestry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "residences", ["ancestry"], name: "index_residences_on_ancestry", using: :btree

  create_table "resultlines", force: true do |t|
    t.decimal  "total"
    t.decimal  "pngs17"
    t.string   "status"
    t.string   "remark"
    t.integer  "examresult_id"
    t.integer  "student_id"
    t.decimal  "pngk"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.string   "authname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "rxparts", force: true do |t|
    t.integer  "part_id"
    t.string   "lponum"
    t.string   "donum"
    t.decimal  "quantity"
    t.decimal  "unitcost"
    t.decimal  "totalcost"
    t.date     "rdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scores", force: true do |t|
    t.integer  "type_id"
    t.string   "description"
    t.decimal  "marks"
    t.decimal  "weightage"
    t.decimal  "score"
    t.decimal  "completion"
    t.boolean  "formative"
    t.integer  "grade_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scsessions", force: true do |t|
    t.integer  "counselling_id"
    t.datetime "scsessiondt"
    t.time     "scsessiondtduration"
    t.integer  "scsappointnum"
    t.string   "scsessiontype"
    t.string   "issue"
    t.text     "suggestion"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shortessays", force: true do |t|
    t.string   "item"
    t.string   "subquestion"
    t.decimal  "submark"
    t.text     "subanswer"
    t.integer  "examquestion_id"
    t.string   "keyword"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "spmresults", force: true do |t|
    t.integer  "student_id"
    t.string   "spm_subject"
    t.integer  "spmsubject_id"
    t.string   "grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff_appraisal_skts", force: true do |t|
    t.integer  "staff_appraisal_id"
    t.integer  "priority"
    t.string   "description"
    t.integer  "half"
    t.string   "indicator"
    t.string   "acheivment"
    t.decimal  "progress"
    t.text     "notes"
    t.boolean  "is_dropped"
    t.date     "dropped_on"
    t.string   "drop_reasons"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff_appraisals", force: true do |t|
    t.integer  "staff_id"
    t.date     "evaluation_year"
    t.integer  "eval1_by"
    t.integer  "eval2_by"
    t.boolean  "is_skt_submit"
    t.date     "skt_submit_on"
    t.boolean  "is_skt_endorsed"
    t.date     "skt_endorsed_on"
    t.text     "skt_pyd_report"
    t.boolean  "is_skt_pyd_report_done"
    t.date     "skt_pyd_report_on"
    t.text     "skt_ppp_report"
    t.boolean  "is_skt_ppp_report_done"
    t.date     "skt_ppp_report_on"
    t.boolean  "is_submit_for_evaluation"
    t.date     "submit_for_evaluation_on"
    t.integer  "g1_questions"
    t.integer  "g2_questions"
    t.integer  "g3_questions"
    t.decimal  "e1g1q1"
    t.decimal  "e1g1q2"
    t.decimal  "e1g1q3"
    t.decimal  "e1g1q4"
    t.decimal  "e1g1q5"
    t.decimal  "e1g1_total"
    t.decimal  "e1g1_percent"
    t.decimal  "e1g2q1"
    t.decimal  "e1g2q2"
    t.decimal  "e1g2q3"
    t.decimal  "e1g2q4"
    t.decimal  "e1g2_total"
    t.decimal  "e1g2_percent"
    t.decimal  "e1g3q1"
    t.decimal  "e1g3q2"
    t.decimal  "e1g3q3"
    t.decimal  "e1g3q4"
    t.decimal  "e1g3q5"
    t.decimal  "e1g3_total"
    t.decimal  "e1g3_percent"
    t.decimal  "e1g4"
    t.decimal  "e1g4_percent"
    t.decimal  "e1_total"
    t.integer  "e1_years"
    t.integer  "e1_months"
    t.text     "e1_performance"
    t.text     "e1_progress"
    t.boolean  "is_submit_e2"
    t.date     "submit_e2_on"
    t.decimal  "e2g1q1"
    t.decimal  "e2g1q2"
    t.decimal  "e2g1q3"
    t.decimal  "e2g1q4"
    t.decimal  "e2g1q5"
    t.decimal  "e2g1_total"
    t.decimal  "e2g1_percent"
    t.decimal  "e2g2q1"
    t.decimal  "e2g2q2"
    t.decimal  "e2g2q3"
    t.decimal  "e2g2q4"
    t.decimal  "e2g2_total"
    t.decimal  "e2g2_percent"
    t.decimal  "e2g3q1"
    t.decimal  "e2g3q2"
    t.decimal  "e2g3q3"
    t.decimal  "e2g3q4"
    t.decimal  "e2g3q5"
    t.decimal  "e2g3_total"
    t.decimal  "e2g3_percent"
    t.decimal  "e2g4"
    t.decimal  "e2g4_percent"
    t.decimal  "e2_total"
    t.integer  "e2_years"
    t.integer  "e2_months"
    t.text     "e2_performance"
    t.decimal  "evaluation_total"
    t.boolean  "is_complete"
    t.date     "is_completed_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff_attendances", force: true do |t|
    t.integer  "thumb_id"
    t.datetime "logged_at"
    t.string   "log_type"
    t.string   "reason"
    t.boolean  "trigger"
    t.integer  "approved_by"
    t.boolean  "is_approved"
    t.date     "approved_on"
    t.integer  "status"
    t.string   "review"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff_grades", force: true do |t|
    t.string   "name"
    t.string   "grade"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "classification_id"
    t.string   "group_id"
    t.string   "schemename"
  end

  create_table "staff_shifts", force: true do |t|
    t.string   "name"
    t.time     "start_at"
    t.time     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffcourses", force: true do |t|
    t.string   "name"
    t.integer  "coursetype"
    t.string   "provider"
    t.string   "location"
    t.decimal  "duration",      precision: 4, scale: 1, default: 0.0
    t.integer  "duration_type"
    t.string   "proponent"
    t.decimal  "cost",          precision: 8, scale: 2, default: 2.0
    t.date     "course_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffemploygrades", force: true do |t|
    t.integer  "staffemployscheme_id"
    t.integer  "employgrade_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffemployschemes", force: true do |t|
    t.string   "glass"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", force: true do |t|
    t.string   "icno"
    t.string   "name"
    t.integer  "titlecd_id"
    t.string   "code"
    t.string   "fileno"
    t.integer  "position_old"
    t.string   "coemail"
    t.date     "cobirthdt"
    t.string   "bloodtype"
    t.string   "cooftelno"
    t.string   "cooftelext"
    t.string   "addr"
    t.integer  "poskod_id"
    t.integer  "mrtlstatuscd"
    t.integer  "statecd"
    t.integer  "country_cd"
    t.string   "employscheme"
    t.integer  "employstatus"
    t.string   "appointstatus"
    t.date     "appointdt"
    t.date     "schemedt"
    t.date     "confirmdt"
    t.date     "posconfirmdate"
    t.string   "appointby"
    t.string   "svchead"
    t.string   "svctype"
    t.string   "pensionstat"
    t.date     "pensiondt"
    t.string   "uniformstat"
    t.string   "kwspcode"
    t.string   "taxcode"
    t.string   "bank"
    t.string   "bankaccno"
    t.string   "bankacctype"
    t.integer  "race"
    t.integer  "religion"
    t.string   "phonecell"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "staffgrade_id"
    t.integer  "gender"
    t.date     "pension_confirm_date"
    t.date     "wealth_decleration_date"
    t.date     "promotion_date"
    t.date     "reconfirmation_date"
    t.date     "to_current_grade_date"
    t.decimal  "starting_salary"
    t.string   "transportclass_id"
    t.integer  "country_id"
    t.string   "birthcertno"
    t.integer  "thumb_id"
    t.integer  "time_group_id"
    t.integer  "staff_shift_id"
    t.integer  "att_colour"
    t.string   "phonehome"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffsearch2s", force: true do |t|
    t.string   "keywords"
    t.integer  "position"
    t.integer  "staff_grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffsearches", force: true do |t|
    t.string   "keywords"
    t.integer  "position"
    t.integer  "staff_grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stationeries", force: true do |t|
    t.string   "code"
    t.string   "category"
    t.string   "unittype"
    t.decimal  "maxquantity"
    t.decimal  "minquantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_attendances", force: true do |t|
    t.integer  "student_id"
    t.boolean  "attend"
    t.integer  "weeklytimetable_details_id"
    t.string   "reason"
    t.string   "action"
    t.string   "status"
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_counseling_sessions", force: true do |t|
    t.integer  "student_id"
    t.integer  "case_id"
    t.datetime "requested_at"
    t.text     "alt_dates"
    t.string   "c_type"
    t.string   "c_scope"
    t.integer  "duration"
    t.boolean  "is_confirmed"
    t.datetime "confirmed_at"
    t.text     "issue_desc"
    t.text     "notes"
    t.integer  "file_id"
    t.text     "suggestions"
    t.integer  "staff_id"
    t.integer  "created_by"
    t.string   "created_by_type"
    t.integer  "confirmed_by"
    t.string   "confirmed_by_type"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_discipline_cases", force: true do |t|
    t.integer  "reported_by"
    t.integer  "student_id"
    t.integer  "infraction_id"
    t.text     "description"
    t.date     "reported_on"
    t.integer  "assigned_to"
    t.date     "assigned_on"
    t.string   "status"
    t.integer  "file_id"
    t.text     "investigation_notes"
    t.string   "action_type"
    t.text     "other_info"
    t.date     "case_created_on"
    t.text     "action"
    t.integer  "location_id"
    t.integer  "assigned2_to"
    t.date     "assigned2_on"
    t.boolean  "is_innocent"
    t.date     "closed_at_college_on"
    t.date     "sent_to_board_on"
    t.date     "board_meeting_on"
    t.date     "board_decision_on"
    t.text     "board_decision"
    t.date     "appeal_on"
    t.text     "appeal_decision"
    t.date     "appeal_decision_on"
    t.text     "counselor_feedback"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studentattendances", force: true do |t|
    t.integer  "timetable_id"
    t.integer  "student_id"
    t.boolean  "attend"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studentattendancesearches", force: true do |t|
    t.integer  "schedule_id"
    t.date     "intake_id"
    t.string   "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studentcounselingsearches", force: true do |t|
    t.string   "matrixno"
    t.integer  "case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studentdisciplinesearches", force: true do |t|
    t.string   "name"
    t.integer  "programme"
    t.date     "intake"
    t.string   "matrixno"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "icno"
    t.string   "name"
    t.string   "matrixno"
    t.string   "sstatus"
    t.string   "stelno"
    t.string   "ssponsor"
    t.integer  "gender"
    t.date     "sbirthdt"
    t.integer  "mrtlstatuscd"
    t.string   "semail"
    t.date     "regdate"
    t.integer  "course_id"
    t.integer  "specilisation"
    t.integer  "group_id"
    t.string   "physical"
    t.string   "allergy"
    t.string   "disease"
    t.string   "bloodtype"
    t.string   "medication"
    t.text     "remarks"
    t.string   "offer_letter_serial"
    t.string   "race"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.text     "address"
    t.text     "address_posbasik"
    t.date     "end_training"
    t.date     "intake"
    t.string   "specialisation"
    t.integer  "intake_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "studentsearches", force: true do |t|
    t.string   "icno"
    t.string   "name"
    t.string   "matrixno"
    t.string   "ssponsor"
    t.integer  "mrtlstatuscd"
    t.integer  "course_id"
    t.string   "physical"
    t.date     "end_training"
    t.date     "intake"
    t.integer  "gender"
    t.string   "race"
    t.string   "bloodtype"
    t.string   "sstatus"
    t.date     "end_training2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: true do |t|
    t.string   "supplycode"
    t.string   "category"
    t.string   "unittype"
    t.decimal  "maxquantity"
    t.decimal  "minquantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tenants", force: true do |t|
    t.integer  "location_id"
    t.integer  "staff_id"
    t.integer  "student_id"
    t.date     "keyaccept"
    t.date     "keyexpectedreturn"
    t.date     "keyreturned"
    t.boolean  "force_vacate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetable_periods", force: true do |t|
    t.integer  "timetable_id"
    t.integer  "sequence"
    t.integer  "day_name"
    t.time     "start_at"
    t.time     "end_at"
    t.boolean  "is_break"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timetables", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "description"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "titles", force: true do |t|
    t.string   "titlecode"
    t.string   "name"
    t.boolean  "berhormat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topicdetails", force: true do |t|
    t.string   "topic_name"
    t.integer  "topic_code"
    t.time     "duration"
    t.float    "version_no"
    t.text     "objctives"
    t.text     "contents"
    t.time     "theory"
    t.time     "tutorial"
    t.time     "practical"
    t.integer  "prepared_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainingnotes", force: true do |t|
    t.integer  "timetable_id"
    t.string   "title"
    t.string   "reference"
    t.string   "version"
    t.string   "staff_id"
    t.date     "release"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "topicdetail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainingreports", force: true do |t|
    t.integer  "classtype"
    t.integer  "timetable_id"
    t.boolean  "location_state"
    t.text     "ls_comment"
    t.text     "staff_comment"
    t.integer  "staff_id"
    t.boolean  "submit"
    t.text     "tpa_comment"
    t.integer  "tpa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainingrequests", force: true do |t|
    t.integer  "staffcourse_id"
    t.integer  "staff_id"
    t.integer  "appraisal_id"
    t.string   "reason"
    t.boolean  "submit"
    t.date     "submitdate"
    t.boolean  "approved"
    t.integer  "approvedby_id"
    t.date     "approveddate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainings", force: true do |t|
    t.string   "code"
    t.string   "combo_code"
    t.string   "name"
    t.string   "course_type"
    t.string   "ancestry"
    t.integer  "ancestry_depth"
    t.text     "objective"
    t.integer  "duration"
    t.integer  "duration_type"
    t.integer  "credits"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainneeds", force: true do |t|
    t.string   "name"
    t.string   "reason"
    t.integer  "confirmedby_id"
    t.integer  "evaluation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_claim_allowances", force: true do |t|
    t.integer  "travel_claim_id"
    t.integer  "expenditure_type"
    t.string   "receipt_code"
    t.date     "spent_on"
    t.decimal  "amount"
    t.decimal  "quantity"
    t.boolean  "checker"
    t.string   "checker_notes"
    t.decimal  "total"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_claim_logs", force: true do |t|
    t.integer  "travel_request_id"
    t.date     "travel_on"
    t.time     "start_at"
    t.time     "finish_at"
    t.string   "destination"
    t.decimal  "mileage"
    t.decimal  "km_money"
    t.boolean  "checker"
    t.string   "checker_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_claim_mileage_rates", force: true do |t|
    t.integer  "km_low"
    t.integer  "km_high"
    t.decimal  "a_group",    precision: 4, scale: 2
    t.decimal  "b_group",    precision: 4, scale: 2
    t.decimal  "c_group",    precision: 4, scale: 2
    t.decimal  "d_group",    precision: 4, scale: 2
    t.decimal  "e_group",    precision: 4, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_claim_receipts", force: true do |t|
    t.integer  "travel_claim_id"
    t.integer  "expenditure_type"
    t.string   "receipt_code"
    t.date     "spent_on"
    t.decimal  "amount"
    t.decimal  "quantity"
    t.boolean  "checker"
    t.string   "checker_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_claims", force: true do |t|
    t.integer  "staff_id"
    t.date     "claim_month"
    t.decimal  "advance"
    t.decimal  "total"
    t.boolean  "is_submitted"
    t.date     "submitted_on"
    t.boolean  "is_checked"
    t.boolean  "is_returned"
    t.date     "checked_on"
    t.integer  "checked_by"
    t.string   "notes"
    t.boolean  "is_approved"
    t.date     "approved_on"
    t.integer  "approved_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_claims_transport_groups", force: true do |t|
    t.string   "group_name",  limit: 2,                         null: false
    t.decimal  "salary_low",            precision: 8, scale: 2
    t.decimal  "salary_high",           precision: 8, scale: 2
    t.integer  "cc_low"
    t.integer  "cc_high"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travel_requests", force: true do |t|
    t.integer  "staff_id"
    t.integer  "document_id"
    t.integer  "staff_course_conducted_id"
    t.string   "destination"
    t.datetime "depart_at"
    t.datetime "return_at"
    t.boolean  "own_car"
    t.string   "own_car_notes"
    t.boolean  "dept_car"
    t.boolean  "others_car"
    t.boolean  "taxi"
    t.boolean  "bus"
    t.boolean  "train"
    t.boolean  "plane"
    t.boolean  "other"
    t.string   "other_desc"
    t.boolean  "is_submitted"
    t.date     "submitted_on"
    t.integer  "replaced_by"
    t.boolean  "mileage"
    t.boolean  "mileage_replace"
    t.integer  "hod_id"
    t.boolean  "hod_accept"
    t.date     "hod_accept_on"
    t.integer  "travel_claim_id"
    t.boolean  "is_travel_log_complete"
    t.decimal  "log_mileage"
    t.decimal  "log_fare"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traveldetailreceipts", force: true do |t|
    t.integer  "traveldetail_id"
    t.integer  "type_id"
    t.string   "receiptnp"
    t.decimal  "rvalue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traveldetails", force: true do |t|
    t.integer  "travelclaimrequest_id"
    t.date     "travelday"
    t.time     "departure"
    t.time     "arrival"
    t.text     "description"
    t.decimal  "distance"
    t.decimal  "fare"
    t.decimal  "value"
    t.boolean  "lodging"
    t.boolean  "meals"
    t.boolean  "dinner"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "txsupplies", force: true do |t|
    t.integer "part_id"
    t.integer "receiver_id"
    t.decimal "quantity"
    t.date    "tdate"
    t.text    "details"
  end

  create_table "users", force: true do |t|
    t.string   "login",                     limit: 40
    t.string   "name",                      limit: 100, default: ""
    t.string   "email",                     limit: 100
    t.string   "crypted_password",          limit: 40
    t.string   "salt",                      limit: 40
    t.string   "remember_token",            limit: 40
    t.datetime "remember_token_expires_at"
    t.integer  "staff_id"
    t.integer  "student_id"
    t.boolean  "isstaff"
    t.string   "icno"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

  create_table "usesupplies", force: true do |t|
    t.integer  "supplier_id"
    t.integer  "issuedby"
    t.integer  "receivedby"
    t.decimal  "quantity"
    t.date     "issuedate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weeklytimetable_details", force: true do |t|
    t.integer  "subject"
    t.integer  "topic"
    t.integer  "time_slot"
    t.integer  "lecturer_id"
    t.integer  "weeklytimetable_id"
    t.integer  "day2"
    t.boolean  "is_friday"
    t.integer  "time_slot2"
    t.integer  "location"
    t.integer  "lecture_method"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weeklytimetables", force: true do |t|
    t.integer  "programme_id"
    t.integer  "intake_id"
    t.integer  "group_id"
    t.date     "startdate"
    t.date     "enddate"
    t.integer  "semester"
    t.integer  "prepared_by"
    t.integer  "endorsed_by"
    t.integer  "format1"
    t.integer  "format2"
    t.integer  "week"
    t.boolean  "is_submitted"
    t.date     "submitted_on"
    t.boolean  "hod_approved"
    t.date     "hod_approved_on"
    t.boolean  "hod_rejected"
    t.date     "hod_rejected_on"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weeklytimetablesearches", force: true do |t|
    t.integer  "programme_id"
    t.date     "startdate"
    t.date     "enddate"
    t.integer  "preparedby"
    t.integer  "intake_id"
    t.integer  "intake"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
