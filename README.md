# 465

Using the paper 9_2015jamdsm0037.pdf, a model of a double wishbone suspension was created to use in HEEDS to optimize curve fit.

To run the model run `optimize.m` 

Definition of what things do
- `find_E.m` E is the shperical joint between the upright steering arm and the tie rod. So solve for this point, there are three nonlinear equations. I tried using MATALBs numerical solver, but it was not working well. This runs through all positions of theta to calculate new location of E.
- `findEsingle.m` this is a terribly inefficient way of finding a solution to the system finding the new location of E. Did not have time to make a better one, and this takes a while plus often shows no movement, so it is incorrect.
- `get_init_struct.m` Given the variables allowed to move, this creates a struct that will be passed to `kin4.m`.
- `get_rotation.m` defines a simple roation about two axis.
- `get_struct_from_sheet.m` given an output from OptimumK, this grabs the front left suspension points and puts them into a struct to be used later.
- `kin4.m` this finds the motion of the suspension for different values of theta - lower wishbone angle.
- `optimize.m` For a run from an output from OptimumK, running will generate curves. However, for HEEDs, uncomment the section where variables are directly set. Reading the excel file is useless and wastes time during HEEDs.
- `plot_results.m` this generates a plot of the following
    * Toe vs wheel travel (incorect as of now)
    * Camber vs wheel travel
    * Caster vs Wheel travel (also incorrect)
    * Track Variations vs Wheel Travel
    * KPI vs Wheel Travel
- `plots.m` this is a simple thing used to look at new potential desired curves for different results. 
