class DownloadsController < ApplicationController
  # GET /downloads
  # GET /downloads.xml
  def index
    @downloads = Download.all
  #  @download_unit = @downloads.group_by { |t| t.doc_group }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @downloads }
    end
  end

  # GET /downloads/1
  # GET /downloads/1.xml
  def show
    @download = Download.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @download }
    end
  end

  # GET /downloads/new
  # GET /downloads/new.xml
  def new
    @download = Download.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @download }
    end
  end

  # GET /downloads/1/edit
  def edit
    @download = Download.find(params[:id])
  end

  # POST /downloads
  # POST /downloads.xml
  def create
    @download = Download.new(params[:download])

    respond_to do |format|
      if @download.save
        flash[:notice] = 'Download was successfully created.'
        format.html { redirect_to(@download) }
        format.xml  { render :xml => @download, :status => :created, :location => @download }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /downloads/1
  # PUT /downloads/1.xml
  def update
    @download = Download.find(params[:id])

    respond_to do |format|
      if @download.update_attributes(params[:download])
        flash[:notice] = 'Download was successfully updated.'
        format.html { redirect_to(@download) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @download.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /downloads/1
  # DELETE /downloads/1.xml
  def destroy
    @download = Download.find(params[:id])
    @download.destroy

    respond_to do |format|
      format.html { redirect_to(downloads_url) }
      format.xml  { head :ok }
    end
  end
  
  def doc_upload_kkm
     # @downloads = Download.search(params[:all])
      @downloads = Download.find(:all, :conditions => {:doc_group => 'KKM'})
  end
  
  def doc_upload_tbl
     # @downloads = Download.search(params[:all])
      @downloads = Download.find(:all, :conditions => {:doc_group => 'TBL'})
  end
  
  def doc_upload_ran
     # @downloads = Download.search(params[:all])
      @downloads = Download.find(:all, :conditions => {:doc_group => 'RAN'})
  end
  
  def doc_upload_ks
     # @downloads = Download.search(params[:all])
      @downloads = Download.find(:all, :conditions => {:doc_group => 'KS'})
  end
  
  def doc_upload_wp
     # @downloads = Download.search(params[:all])
      @downloads = Download.find(:all, :conditions => {:doc_group => 'WP'})
  end
  
  def exam_attendance
    @downloads = Download.find(:all)
    render :layout => 'report'
   
  end
  
  def check_form
    @downloads = Download.find(:all)
    render :layout => 'report'
   
  end
  
  def penilaian_kursus
    @downloads = Download.find(:all)
    render :layout => 'report'
   
  end
  
  def analisa_kursus
    @downloads = Download.find(:all)
    render :layout => 'report'
   
  end
  
  def laporan_kursus
    @downloads = Download.find(:all)
    render :layout => 'report'
   
  end
  
  def aduan_q
    @downloads = Download.find(:all)
    render :layout => 'report'
   
  end
  
   def aduan_q_bulanan
    @downloads = Download.find(:all)
    render :layout => 'report'
   
  end
  
   def feedback_customer
    @downloads = Download.find(:all)
    render :layout => 'report'
   
  end
  
   def penilaian_latihan
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def laporan_penilaian_latihan
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def penilai_jurulatih
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def skor_purata_jurulatih
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def penilaian_pensyarah
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
   def black_list_pensyarah
    @downloads = Download.find(:all)
    render :layout => 'report'
  end

  def analisa_exam
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
   def final_exam
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def amaran_komandan
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def amaran_pengarah
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
   def simpanan_pelatih
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
   def kediaman_asrama
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
    def maklumat_pelatih
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
    def aduan_sajian
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
    def ujian_cergas
    @downloads = Download.find(:all)
    render :layout => 'report'
  end

     def rancangan_latihan
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
     def bbm
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
     def feedback_lawatan
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
     def rekod_latihan
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def analisa_kejurulatihan
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def hadir_kursus
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
  def kaji_selidik
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
   def matrik_jurulatih
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
    def pinjam_kereta
    @downloads = Download.find(:all)
    render :layout => 'report'
  end

    def tempahan_pesanan
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
  
     def penilaian_pembekal
    @downloads = Download.find(:all)
    render :layout => 'report'
  end
end
