# R_deceased_donor_assessment_report
This is a self-contained program to run in RStudio. When run, it prompts the user for the recipient's MRN, and the donor's ID, and then connects to the HistoTrac database to automatically compile a report. See below for the data compiled:

Version 3.0 is the initial version.
Report includes the following data:
1. Patient name and MRN.
2. Donor ID.
3. Organ type (from value in HistoTrac).
4. A table with patient and donor typing in low-resolution format. Table also includes the number of mismatches at each locus.
5. A list of all of the mismatched antigens.
6. Summary matching at the A, B, C, and DQ loci.
7. Date of the most recent sample tested by single antigen beads.
8. Age of the most recent sample.
9. A graph depicting the MFI values for each bead that corresponds to one of the mismatched donor antigens.
10. A table listing the sample date, sample number, and bead values for each of the SAB beads corresponding to a mismatched donor antigen.

Limitations of V3.0:
1. Allele-specific antibodies that are the same serologic specificity as the recipient will not show up in the graph or the table. Subsequent versions will address this issue.
2. If the donor encodes antigens that are not represented on the SAB panel (mainly an issue for DPB1), they will not show up on the graph or the table.
