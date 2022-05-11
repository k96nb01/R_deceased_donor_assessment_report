# R_deceased_donor_assessment_report
This is a self-contained program designed to be launched from a web app. The web app is a “shiny app,” and needs to be run in RStudio. The RMarkdown document can alternatively be run directly from RStudio, without the web app.

Version 5.0 changes:
1.	A shiny app was developed to act as a launcher of the report. Two files are required to use the web app: “app.R” and “Deceased-donor-VXM-report.V5.0.rmd” have to be placed in the same folder for the program to run. Starting the app then brings up a web page where the recipient MRN and donor ID can be input, a button allows you to check that the MRN and donor ID are correct, and then another button will create the report. 
2.	Note the rmd file can still be used by itself. In that case, the patient MRN and donor ID will need to be put in the “params” section at the top of the document, and then the “knit” button will generate the report.
3.	Various changes were made to allow the report to be launched from the web app.
4.	The font size was decreased.

Limitations of V5.0:
1.	If the donor encodes antigens that are not represented on the SAB panel (mainly an issue for DPB1), they will not show up on the graph or the table.

This is a self-contained program to run in RStudio. When run, it prompts the user for the recipient's MRN, and the donor's ID, and then connects to the HistoTrac database to automatically compile a report. See below for the data compiled:

Version 4.0 changes:
1.	DOB for donor was added as a second identity value, and ABO values for recipient and donor were added.
2.	UNOS CPRA for the recipient was added.
3.	A link to HaploStats pre-populated with the donor type appears on the first page. This allows for easy imputation to high resolution A, B, C, DRB1, DRB3/4/5, and DQB1.
4.	A table for special XM considerations was added.
5.	A table of sensitizing events was added.
6.	DSAs are now calculated on all donor types, not just mismatches. This will make the graph more cluttered and the DSA table longer, but will ensure allele-specific antibodies to recipient antigens will show up as DSAs.
7.	A new column on the DSA table was added, “bead result,” to indicate if a particular specificity was reported positive or negative by manual analysis.
8.	The DSA table highlights any MFI ≥ 1,000 in yellow.
9.	The DSA table highlights any bead resulted as positive in orange.
Limitations of V4.0:
2.	If the donor encodes antigens that are not represented on the SAB panel (mainly an issue for DPB1), they will not show up on the graph or the table.

Version 3.0 is the initial version. Report includes the following data:
1.	Patient name and MRN.
2.	Donor ID.
3.	Organ type (from value in HistoTrac).
4.	A table with patient and donor typing in low-resolution format. Table also includes the number of mismatches at each locus.
5.	A list of all of the mismatched antigens.
6.	Summary matching at the A, B, C, and DQ loci.
7.	Date of the most recent sample tested by single antigen beads.
8.	Age of the most recent sample.
9.	A graph depicting the MFI values for each bead that corresponds to one of the mismatched donor antigens.
10.	A table listing the sample date, sample number, and bead values for each of the SAB beads corresponding to a mismatched donor antigen.
Limitations of V3.0:
3.	Allele-specific antibodies that are the same serologic specificity as the recipient will not show up in the graph or the table. Subsequent versions will address this issue. (Corrected in V4.0)
4.	If the donor encodes antigens that are not represented on the SAB panel (mainly an issue for DPB1), they will not show up on the graph or the table.
