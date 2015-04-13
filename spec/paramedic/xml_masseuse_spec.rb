require 'nokogiri'

module Paramedic
  describe XMLMasseuse do
    describe '#to_xml' do
      subject{ described_class.new(xml, escape_tags: escape_tags).to_xml }

      context 'with no escape tags specified' do
        let(:escape_tags) { [] }

        context 'with a space between tags' do
          let(:xml) {
            <<-end_of_xml
            <root>
              <a>value1</a>
              <b>value2</b>
            </root>
            end_of_xml
          }

          it 'strips the spaces between tags' do
            expect(subject).to eq "<?xml version=\"1.0\"?>\n<root><a>value1</a><b>value2</b></root>\n"
          end

          it 'has a newline after the declaration' do
            expect(subject).to include("<?xml version=\"1.0\"?>\n")
          end

          it 'has a newline at the end of the document' do
            expect(subject[-1]).to eq "\n"
          end
        end

        context 'with complex xml' do
          let(:xml) {
            <<-end_of_xml
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
          }

          it 'does not collapse elements' do
            expect(subject.scan(/<USERQRY><\/USERQRY>/).count).to be 1
          end
        end
      end

      context 'with double encode tags specified' do
        let(:escape_tags) { ['COMMENT'] }

        context 'when the encode tag content is text' do
          let(:expected_result) { <<-end_of_xml
<?xml version="1.0"?>
<ViewCommand><COMMENT>\n  a\nb\n  </COMMENT></ViewCommand>
          end_of_xml
          }

          let(:xml) {
            <<-end_of_xml
<?xml version="1.0"?>
<ViewCommand>
  <COMMENT>
  a
b
  </COMMENT>
</ViewCommand>
            end_of_xml
          }

          it 'html escapes specified elements' do
            expect(subject).to eq expected_result
          end
        end

        context 'when the encode tag content is markup' do
          let(:expected_result) { <<-end_of_xml
<?xml version="1.0"?>
<ViewCommand><COMMENT>&lt;html&gt;&lt;body&gt;&lt;p&gt;None&lt;/p&gt;&lt;/body&gt;&lt;/html&gt;</COMMENT></ViewCommand>
          end_of_xml
          }

          let(:xml) {
            <<-end_of_xml
<?xml version="1.0"?>
<ViewCommand>
  <COMMENT>
    <html>
      <body>
        <p>None</p>
      </body>
    </html>
  </COMMENT>
</ViewCommand>
            end_of_xml
          }

          it 'html escapes specified elements' do
            expect(subject).to eq expected_result
          end
        end
      end
    end
  end
end
