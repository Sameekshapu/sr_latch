class sr_coverage extends uvm_subscriber #(sr_sequence_item);

  //----------------------------------------------------------------------------
  `uvm_component_utils(sr_coverage)
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="sr_coverage",uvm_component parent);
    super.new(name,parent);
 //   dut_cov=new();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  sr_sequence_item req;
  real cov;
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  covergroup functional_cov;
    option.per_instance= 1;
    option.comment     = "functional_cov";
    option.name        = "functional_cov";
    option.auto_bin_max= 4;
    
    
    S:coverpoint req.s;
    //{ 
        //bins s_high={1};
       // bins s_low ={0};
    //}

    R:coverpoint req.r;
    //{ 
      //  bins r_high={1};
        //bins r_low ={0};
    //}

    SXR:cross S,R;
 
  endgroup:functional_cov;
  functional_cov=new();

  //----------------------------------------------------------------------------

  //---------------------  write method ----------------------------------------
  function void write(sr_sequence_item t);
    req=t;
    functional_cov.sample();
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function void extract_phase(uvm_phase phase);
    super.extract_phase(phase);
    cov=functional_cov.get_coverage();
  endfunction
  //----------------------------------------------------------------------------


  //----------------------------------------------------------------------------
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(),$sformatf("Coverage is %f",cov),UVM_MEDIUM)
  endfunction
  //----------------------------------------------------------------------------
  
endclass:sr_coverage
