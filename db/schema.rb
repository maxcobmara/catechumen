# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110223204834) do

  create_table "addbooks", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "address"
    t.string   "mail"
    t.string   "web"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addsuppliers", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "lpono"
    t.string   "document"
    t.decimal  "quantity"
    t.decimal  "unitcost"
    t.date     "received"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "appraisals", :force => true do |t|
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

  create_table "assetlosses", :force => true do |t|
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

  create_table "assetnums", :force => true do |t|
    t.integer  "asset_id"
    t.string   "assetnumname"
    t.string   "assetadnum"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets", :force => true do |t|
    t.string   "assetcode"
    t.string   "cardno"
    t.integer  "dept_id"
    t.integer  "assettype"
    t.boolean  "bookable"
    t.string   "name"
    t.string   "category"
    t.string   "type"
    t.integer  "manufacturer_id"
    t.string   "model"
    t.string   "serialno"
    t.text     "otherinfo"
    t.string   "orderno"
    t.decimal  "purchaseprice"
    t.date     "purchasedate"
    t.date     "receiveddate"
    t.integer  "receiver_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignedto_id"
    t.boolean  "locassigned"
    t.integer  "status"
    t.integer  "location_id"
  end

  create_table "assettracks", :force => true do |t|
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

  create_table "attendances", :force => true do |t|
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

  create_table "books", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "issn"
    t.string   "edition"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "bulletins", :force => true do |t|
    t.string   "headline"
    t.text     "content"
    t.integer  "postedby_id"
    t.date     "publishdt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "cofiles", :force => true do |t|
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

  create_table "counsellings", :force => true do |t|
    t.integer  "student_id"
    t.integer  "cofile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courseevaluations", :force => true do |t|
    t.integer  "student_id"
    t.integer  "programme_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "coursecode"
    t.string   "name"
    t.integer  "parent_id"
    t.string   "objective"
    t.string   "coursescope"
    t.string   "coursedefinition"
    t.string   "abbreviation"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "disposals", :force => true do |t|
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

  create_table "docs", :force => true do |t|
    t.integer  "curriculum_id"
    t.integer  "cofile_id"
    t.string   "name"
    t.decimal  "version"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
  end

  create_table "evactivities", :force => true do |t|
    t.integer  "appraisal_id"
    t.date     "evaldt"
    t.string   "evactivity"
    t.string   "actlevel"
    t.date     "actdt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.string   "eventname"
    t.string   "location"
    t.text     "participants"
    t.string   "officiated"
    t.string   "createdby"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "eventstdt"
    t.datetime "eventendt"
  end

  create_table "examquestions", :force => true do |t|
    t.integer  "curriculum_id"
    t.string   "questiontype"
    t.string   "question"
    t.text     "answer"
    t.decimal  "marks"
    t.string   "category"
    t.string   "qkeyword"
    t.string   "qstatus"
    t.integer  "creator_id"
    t.date     "createdt"
    t.string   "status"
    t.text     "statusremark"
    t.integer  "editor_id"
    t.date     "editdt"
    t.integer  "approver_id"
    t.date     "approvedt"
    t.boolean  "bplreserve"
    t.boolean  "bplsent"
    t.date     "bplsentdt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", :force => true do |t|
    t.integer  "student_id"
    t.integer  "subject_id"
    t.boolean  "sent_to_BPL"
    t.date     "sent_date"
    t.decimal  "total_formative"
    t.decimal  "score"
    t.boolean  "eligible_for_exam"
    t.boolean  "carry_paper"
    t.decimal  "total_summative"
    t.boolean  "resit"
    t.decimal  "total_marks"
    t.integer  "grading_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "intakes", :force => true do |t|
    t.string   "name"
    t.integer  "intake_no"
    t.date     "year"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kins", :force => true do |t|
    t.integer  "kintype_id"
    t.integer  "staff_id"
    t.integer  "student_id"
    t.string   "name"
    t.date     "kinbirthdt"
    t.string   "phone"
    t.string   "kinaddr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses", :force => true do |t|
    t.integer  "klass_no"
    t.string   "klass_name"
    t.integer  "intake_id"
    t.integer  "programme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "klasses_students", :force => true do |t|
    t.integer  "student_id"
    t.integer  "klass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leaveforstaffs", :force => true do |t|
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

  create_table "leaveforstudents", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
  end

  create_table "librarytransactions", :force => true do |t|
    t.integer  "book_id"
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "loans", :force => true do |t|
    t.integer  "staff_id"
    t.integer  "ltype"
    t.string   "accno"
    t.date     "startdt"
    t.integer  "durationmn"
    t.decimal  "deductions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "maints", :force => true do |t|
    t.integer  "asset_id"
    t.integer  "maintainer_id"
    t.string   "workorderno"
    t.decimal  "maintcost"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.integer  "parent_id"
    t.string   "navlabel"
    t.integer  "position"
    t.boolean  "redirect"
    t.string   "action_name"
    t.string   "controller_name"
  end

  create_table "parts", :force => true do |t|
    t.string   "partcode"
    t.string   "category"
    t.string   "unittype"
    t.decimal  "quantity"
    t.decimal  "maxquantity"
    t.decimal  "minquantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "period_timings", :force => true do |t|
    t.string   "name"
    t.time     "start_time"
    t.time     "end_time"
    t.boolean  "break"
    t.integer  "intake_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "positions", :force => true do |t|
    t.string   "positioncode"
    t.string   "positionname"
    t.string   "unit"
    t.text     "taskmain"
    t.text     "taskother"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
    t.integer  "staffgrade_id"
    t.integer  "staff_id"
  end

  create_table "programmes", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "specialisation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programmes_subjects", :id => false, :force => true do |t|
    t.integer "programme_id"
    t.integer "subject_id"
  end

  create_table "qualifications", :force => true do |t|
    t.integer  "staff_id"
    t.integer  "student_id"
    t.integer  "level_id"
    t.string   "qname"
    t.integer  "institute_id"
    t.string   "institute"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residences", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "rxparts", :force => true do |t|
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

  create_table "scores", :force => true do |t|
    t.integer  "type_id"
    t.string   "description"
    t.decimal  "marks"
    t.decimal  "weightage"
    t.decimal  "actual_score"
    t.decimal  "score"
    t.decimal  "completion"
    t.boolean  "formative"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "grade_id"
  end

  create_table "scsessions", :force => true do |t|
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

  create_table "sdiciplines", :force => true do |t|
    t.integer  "reportedby_id"
    t.integer  "student_id"
    t.text     "details"
    t.date     "reporteddt"
    t.integer  "cofile_id"
    t.date     "casedt"
    t.string   "referredby"
    t.text     "investigation"
    t.string   "status"
    t.text     "action"
    t.date     "closedtcollege"
    t.string   "location"
    t.text     "otherinfo"
    t.date     "bplsenddt"
    t.date     "jtkpdt"
    t.text     "jtkpdecision"
    t.date     "jtkpdescisionrxdt"
    t.date     "appealdt"
    t.text     "appealdecision"
    t.date     "appealdecisionrxdt"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffcourses", :force => true do |t|
    t.string   "name"
    t.integer  "coursetype"
    t.string   "provider"
    t.string   "location"
    t.decimal  "duration",      :precision => 4, :scale => 1, :default => 0.0
    t.integer  "duration_type"
    t.string   "proponent"
    t.decimal  "cost",          :precision => 8, :scale => 2, :default => 2.0
    t.date     "course_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffgrades", :force => true do |t|
    t.string   "sgname"
    t.string   "sgshortname"
    t.integer  "sglevel"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race"
    t.integer  "religion"
    t.string   "phonecell"
    t.boolean  "phonehome"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "staffgrade_id"
    t.integer  "gender"
  end

  create_table "strainings", :force => true do |t|
    t.integer  "appraisal_id"
    t.integer  "staff_id"
    t.string   "name"
    t.string   "place"
    t.date     "sdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", :force => true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "intake_id"
  end

  create_table "subjects", :force => true do |t|
    t.string   "subjectcode"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "credit"
    t.integer  "status"
  end

  create_table "suppliers", :force => true do |t|
    t.string   "supplycode"
    t.string   "category"
    t.string   "unittype"
    t.decimal  "maxquantity"
    t.decimal  "minquantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_table_entries", :force => true do |t|
    t.integer  "intake_id"
    t.integer  "programme_id"
    t.integer  "subject_id"
    t.integer  "topic_id"
    t.integer  "klass_id"
    t.integer  "timetable_week_day"
    t.date     "timetable_date"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "residence_id"
    t.integer  "timing_id"
  end

  create_table "titles", :force => true do |t|
    t.string   "titlecode"
    t.string   "name"
    t.boolean  "berhormat"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", :force => true do |t|
    t.integer  "subject_id"
    t.string   "topic_code"
    t.integer  "sequenceno"
    t.string   "name"
    t.time     "duration"
    t.string   "version"
    t.string   "objective"
    t.text     "content"
    t.text     "activity"
    t.integer  "creator_id"
    t.boolean  "approved"
    t.integer  "approvedby_id"
    t.date     "approved_date"
    t.string   "remarks"
    t.string   "checkcode"
    t.date     "checkdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trainneeds", :force => true do |t|
    t.string   "name"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "confirmedby_id"
    t.integer  "evaluation_id"
  end

  create_table "travelclaims", :force => true do |t|
    t.integer  "travelrequest_id"
    t.datetime "tstartdt"
    t.datetime "treturndt"
    t.decimal  "distance"
    t.decimal  "distancevalue"
    t.decimal  "ptclaimsvalue"
    t.decimal  "allclaimsvalue"
    t.decimal  "othclaimsvalue"
    t.decimal  "exchvalue"
    t.decimal  "exchloss"
    t.decimal  "gtotal"
    t.string   "ifownwhy"
    t.boolean  "claimtype"
    t.date     "submission"
    t.integer  "hod_id"
    t.date     "hodconfirmdt"
    t.decimal  "advance"
    t.decimal  "payable"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "travelrequests", :force => true do |t|
    t.integer  "staff_id"
    t.string   "trcode"
    t.string   "destination"
    t.string   "purpose"
    t.date     "tstartdt"
    t.date     "treturndt"
    t.boolean  "owncar"
    t.boolean  "officecar"
    t.boolean  "otherscar"
    t.boolean  "train"
    t.boolean  "plane"
    t.boolean  "publict"
    t.string   "ifownwhy"
    t.boolean  "claimtype"
    t.date     "submission"
    t.integer  "replacement_id"
    t.integer  "hod_id"
    t.date     "hodconfirmdt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "txsupplies", :force => true do |t|
    t.integer  "part_id"
    t.integer  "receiver_id"
    t.decimal  "quantity"
    t.date     "tdate"
    t.text     "details"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.integer  "staff_id"
    t.integer  "student_id"
    t.boolean  "isstaff"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "usesupplies", :force => true do |t|
    t.integer  "supplier_id"
    t.integer  "issuedby"
    t.integer  "receivedby"
    t.decimal  "quantity"
    t.date     "issuedate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
