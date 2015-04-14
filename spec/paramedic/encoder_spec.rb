require 'nokogiri'

module Paramedic
  describe Encoder do
    describe '#to_s' do
      subject { described_class.new(args).to_s }

      context 'with single characters' do
        let(:args) {
          {
            'char' => char
          }
        }


        context 'with a $' do
          let(:char) { '$' }

          it 'correctly encodes the character' do
            expect(subject).to eq 'char=%24'
          end
        end

        context 'with a %' do
          let(:char) { '%' }

          it 'correctly encodes the character' do
            expect(subject).to eq 'char=%25'
          end
        end

        context 'with a &' do
          let(:char) { '&' }

          it 'correctly encodes the character' do
            expect(subject).to eq 'char=%26'
          end
        end
      end

      context 'with a single parameter' do
        let(:args) {
          {
            key => value
          }
        }

        let(:key) { 'CMD' }

        context 'with a simple value' do
          let(:value) { 'value1' }

          it 'returns the expected string' do
            expect(subject).to eq "#{key}=#{value}"
          end
        end

        context 'with xml' do
          let(:value) {
            XMLMasseuse.new(<<-end_of_xml
<?xml version="1.0"?>
<ViewCommand><GROUP>WEB_RMLEAS</GROUP><PAGE>OCCP</PAGE><COMMAND>SAVE</COMMAND><PARMS>~GROUP=WEB_RMLEAS~MENU=NONE~WHERE=NAME.NAMEID='{{id}}'~INFRAME=Y~PARENTMENUNAME=WEB_RMHOME~PARENTMENUID=MRI_69~PARENTSAVE=Y~PATH=C:\\Program Files (x86)\\MriWeb\\~URL=/mripage.asp~</PARMS>
  <CURRENTKEY>~NAMEID={{id}}~</CURRENTKEY>
  <CURRENTORDERFLDS>~NAMEID='{{id}}'~</CURRENTORDERFLDS>
  <ORDERBY></ORDERBY>
  <WHERE>NAME.NAMEID='{{id}}'</WHERE>
  <USERQRY></USERQRY>
  <GROUP>WEB_RMLEAS</GROUP>
  <MENUNAME></MENUNAME>
  <MENUID></MENUID>
  <INFRAME>Y</INFRAME>
  <PARENTMENUNAME>WEB_RMHOME</PARENTMENUNAME>
  <PARENTMENUID>MRI_69</PARENTMENUID>
  <FILTERID></FILTERID>
  <FORM>OCCP</FORM>
  <CMDBTNS>
    <MRIX_2>CLNTCMD{INSERTROW,NEWOCCP}</MRIX_2>
    <MRIX_3>CLNTCMD{SAVE CLNTCMD{DELETEROW,NEWOCCP} }</MRIX_3>
    <BTNAPPFEE>CLNTCMD{RECALC,CMDID=BTNAPPFEE}</BTNAPPFEE>
  </CMDBTNS>
  <HIDE>
    <BTNAPPFEE>HIDE</BTNAPPFEE>
  </HIDE>
  <UPDATEABLE>Y</UPDATEABLE>
  <ALLOWABANDON>Y</ALLOWABANDON>
  <PARENTSAVE>Y</PARENTSAVE>
  <ABANDON></ABANDON>
  <DELETECOOKIES>COOKIE_1;COOKIE_7;</DELETECOOKIES>
  <CLIENTEXPR></CLIENTEXPR>
  <BASECLIENTEXPR></BASECLIENTEXPR>
  <TABCHANGEEXPR>CLNTCMD{SAVE}</TABCHANGEEXPR>
  <HELPPAGE>RM\\NAVPAGES\\WEB_RMLEAS_OCCP.htm</HELPPAGE>
  <PATH>C:\\Program Files (x86)\\MriWeb\\</PATH>
  <URL>/mripage.asp</URL>
  <COMMENT>
    Your rent.
    37672.66: Start GetWebHtmlAndData
    37672.82      0 elapsed for     BuildMenu
    37672.83      0.0156 elapsed for   Build HTML
    37672.83      0 elapsed for CmdXml to Svr
    37672.85      0 elapsed for cleargroup
    37672.85      0 elapsed for GetData 1
    37672.85      0 elapsed for BaseQry SQL
    37672.85      0 elapsed for BaseQry Fetch
    37672.85      0 elapsed for ExecuteQuery total
    37672.85      0 elapsed for Grid Qry SQL
    37672.86      0.0156 elapsed for Grid Fetch
    37672.86      0 elapsed for Build DataXml (0 Rows)
    37672.86      0.0156 elapsed for GetData
    Evaluate Count: 21
    SQL Time: 0.296875
  </COMMENT>
  <APPLID></APPLID>
</ViewCommand>
end_of_xml
            ).to_xml
          }

          let(:serialized_value) {
            "%3C%3Fxml%20version%3D%221.0%22%3F%3E%0D%0A%3CViewCommand%3E%3CGROUP%3EWEB_RMLEAS%3C%2FGROUP%3E%3CPAGE%3EOCCP%3C%2FPAGE%3E%3CCOMMAND%3ESAVE%3C%2FCOMMAND%3E%3CPARMS%3E~GROUP%3DWEB_RMLEAS~MENU%3DNONE~WHERE%3DNAME.NAMEID%3D'%7B%7Bid%7D%7D'~INFRAME%3DY~PARENTMENUNAME%3DWEB_RMHOME~PARENTMENUID%3DMRI_69~PARENTSAVE%3DY~PATH%3DC%3A%5CProgram%20Files%20(x86)%5CMriWeb%5C~URL%3D%2Fmripage.asp~%3C%2FPARMS%3E%3CCURRENTKEY%3E~NAMEID%3D%7B%7Bid%7D%7D~%3C%2FCURRENTKEY%3E%3CCURRENTORDERFLDS%3E~NAMEID%3D'%7B%7Bid%7D%7D'~%3C%2FCURRENTORDERFLDS%3E%3CORDERBY%3E%3C%2FORDERBY%3E%3CWHERE%3ENAME.NAMEID%3D'%7B%7Bid%7D%7D'%3C%2FWHERE%3E%3CUSERQRY%3E%3C%2FUSERQRY%3E%3CGROUP%3EWEB_RMLEAS%3C%2FGROUP%3E%3CMENUNAME%3E%3C%2FMENUNAME%3E%3CMENUID%3E%3C%2FMENUID%3E%3CINFRAME%3EY%3C%2FINFRAME%3E%3CPARENTMENUNAME%3EWEB_RMHOME%3C%2FPARENTMENUNAME%3E%3CPARENTMENUID%3EMRI_69%3C%2FPARENTMENUID%3E%3CFILTERID%3E%3C%2FFILTERID%3E%3CFORM%3EOCCP%3C%2FFORM%3E%3CCMDBTNS%3E%3CMRIX_2%3ECLNTCMD%7BINSERTROW%2CNEWOCCP%7D%3C%2FMRIX_2%3E%3CMRIX_3%3ECLNTCMD%7BSAVE%20CLNTCMD%7BDELETEROW%2CNEWOCCP%7D%20%7D%3C%2FMRIX_3%3E%3CBTNAPPFEE%3ECLNTCMD%7BRECALC%2CCMDID%3DBTNAPPFEE%7D%3C%2FBTNAPPFEE%3E%3C%2FCMDBTNS%3E%3CHIDE%3E%3CBTNAPPFEE%3EHIDE%3C%2FBTNAPPFEE%3E%3C%2FHIDE%3E%3CUPDATEABLE%3EY%3C%2FUPDATEABLE%3E%3CALLOWABANDON%3EY%3C%2FALLOWABANDON%3E%3CPARENTSAVE%3EY%3C%2FPARENTSAVE%3E%3CABANDON%3E%3C%2FABANDON%3E%3CDELETECOOKIES%3ECOOKIE_1%3BCOOKIE_7%3B%3C%2FDELETECOOKIES%3E%3CCLIENTEXPR%3E%3C%2FCLIENTEXPR%3E%3CBASECLIENTEXPR%3E%3C%2FBASECLIENTEXPR%3E%3CTABCHANGEEXPR%3ECLNTCMD%7BSAVE%7D%3C%2FTABCHANGEEXPR%3E%3CHELPPAGE%3ERM%5CNAVPAGES%5CWEB_RMLEAS_OCCP.htm%3C%2FHELPPAGE%3E%3CPATH%3EC%3A%5CProgram%20Files%20(x86)%5CMriWeb%5C%3C%2FPATH%3E%3CURL%3E%2Fmripage.asp%3C%2FURL%3E%3CCOMMENT%3E%0D%0A%20%20%20%20Your%20rent.%0D%0A%20%20%20%2037672.66%3A%20Start%20GetWebHtmlAndData%0D%0A%20%20%20%2037672.82%20%20%20%20%20%200%20elapsed%20for%20%20%20%20%20BuildMenu%0D%0A%20%20%20%2037672.83%20%20%20%20%20%200.0156%20elapsed%20for%20%20%20Build%20HTML%0D%0A%20%20%20%2037672.83%20%20%20%20%20%200%20elapsed%20for%20CmdXml%20to%20Svr%0D%0A%20%20%20%2037672.85%20%20%20%20%20%200%20elapsed%20for%20cleargroup%0D%0A%20%20%20%2037672.85%20%20%20%20%20%200%20elapsed%20for%20GetData%201%0D%0A%20%20%20%2037672.85%20%20%20%20%20%200%20elapsed%20for%20BaseQry%20SQL%0D%0A%20%20%20%2037672.85%20%20%20%20%20%200%20elapsed%20for%20BaseQry%20Fetch%0D%0A%20%20%20%2037672.85%20%20%20%20%20%200%20elapsed%20for%20ExecuteQuery%20total%0D%0A%20%20%20%2037672.85%20%20%20%20%20%200%20elapsed%20for%20Grid%20Qry%20SQL%0D%0A%20%20%20%2037672.86%20%20%20%20%20%200.0156%20elapsed%20for%20Grid%20Fetch%0D%0A%20%20%20%2037672.86%20%20%20%20%20%200%20elapsed%20for%20Build%20DataXml%20(0%20Rows)%0D%0A%20%20%20%2037672.86%20%20%20%20%20%200.0156%20elapsed%20for%20GetData%0D%0A%20%20%20%20Evaluate%20Count%3A%2021%0D%0A%20%20%20%20SQL%20Time%3A%200.296875%0D%0A%20%20%3C%2FCOMMENT%3E%3CAPPLID%3E%3C%2FAPPLID%3E%3C%2FViewCommand%3E%0D%0A"
          }

          it 'returns the expected string' do
            expect(subject).to eq "#{key}=#{serialized_value}"
          end
        end
      end

      context 'with two parameters' do
        let(:args) {
          {
            PAGE: :OCCP,
            ID: 'MRI_1'
          }
        }

        it 'returns the expected string' do
          expect(subject).to eq 'PAGE=OCCP&ID=MRI_1'
        end
      end
    end
  end
end
