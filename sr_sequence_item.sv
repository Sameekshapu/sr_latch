class sr_sequence_item extends uvm_sequence_item; 

 

  //------------ i/p || o/p field declaration----------------- 

 

  rand logic  s;  //i/p 

  rand logic  r; 

 

  logic q;        //o/p 

  logic qbar; 

   

  //---------------- register sr_sequence_item class with factory -------- 

  `uvm_object_utils_begin(sr_sequence_item)  

     `uvm_field_int( r    ,UVM_ALL_ON) 

     `uvm_field_int( s    ,UVM_ALL_ON) 

     `uvm_field_int( q    ,UVM_ALL_ON) 

     `uvm_field_int( qbar ,UVM_ALL_ON) 

  `uvm_object_utils_end 

  //---------------------------------------------------------------------------- 

 

  //---------------------------------------------------------------------------- 

  function new(string name="sr_sequence_item"); 

    super.new(name); 

  endfunction 

  //---------------------------------------------------------------------------- 

 

  //---------------------------------------------------------------------------- 

  // write DUT inputs here for printing 

  function string input2string(); 

    return($sformatf(" s=%0b  r=%0b",s,r)); 

  endfunction 

   

  // write DUT outputs here for printing 

  function string output2string(); 

    return($sformatf(" q=%0b qbar=%0b", q,qbar)); 

  endfunction 

     

  function string convert2string(); 

    return($sformatf({input2string(), " || ", output2string()})); 

  endfunction 

  //---------------------------------------------------------------------------- 

 

endclass:sr_sequence_item 

//--------------------------------------------------Sequence.sv------------------------------------------------------------------------ 

 

/*************************************************** 

** class name  : sr_sequence 

** description : generate random input for DUT 

***************************************************/ 

class sr_sequence extends uvm_sequence#(sr_sequence_item); 

  //---------------------------------------------------------------------------- 

  `uvm_object_utils(sr_sequence)             

  //---------------------------------------------------------------------------- 

 

  sr_sequence_item txn; 

  int unsigned LOOP=50; 

 

  //---------------------------------------------------------------------------- 

  function new(string name="sr_sequence");   

    super.new(name); 

  endfunction 

  //---------------------------------------------------------------------------- 

 

  //---------------------------------------------------------------------------- 

  virtual task body(); 

  repeat(LOOP) begin  

    txn=sr_sequence_item::type_id::create("txn"); 

    start_item(txn); 

    txn.randomize(); 

    #5; 

    finish_item(txn); 

  end 

  endtask:body 

  //---------------------------------------------------------------------------- 

endclass:sr_sequence 

 

/*************************************************** 

** class name  : sequence_1 

** description : first set and then memory state 

***************************************************/ 

class sequence_1 extends sr_sequence; 

  //----------------------------------------------------------------------------    

  `uvm_object_utils(sequence_1)       

  //---------------------------------------------------------------------------- 

   

  sr_sequence_item txn; 

  int unsigned LOOP = 20; 

  bit set=1; 

  //---------------------------------------------------------------------------- 

  function new(string name="sequence_1"); 

      super.new(name); 

  endfunction 

  //---------------------------------------------------------------------------- 

   

  //---------------------------------------------------------------------------- 

  task body(); 

    for(int i=0;i<LOOP;i++) begin  

    txn=sr_sequence_item::type_id::create("txn"); 

    start_item(txn); 

    txn.randomize()with{txn.s==set;txn.r==0;}; 

    #5; 

    finish_item(txn); 

    set=set+1; 

  end 

  endtask:body 

  //---------------------------------------------------------------------------- 

   

endclass 

 

/*************************************************** 

** class name  : sequence_2 

** description : first reset and then memory state 

***************************************************/ 

class sequence_2 extends sr_sequence; 

  //----------------------------------------------------------------------------    

  `uvm_object_utils(sequence_2)       

  //---------------------------------------------------------------------------- 

   

  sr_sequence_item txn; 

  int unsigned LOOP=20; 

  bit rst=1; 

   

  //---------------------------------------------------------------------------- 

  function new(string name="sequence_2"); 

      super.new(name); 

  endfunction 

  //---------------------------------------------------------------------------- 

   

  //---------------------------------------------------------------------------- 

  task body(); 

    for(int i=0;i<LOOP;i++) begin  

    txn=sr_sequence_item::type_id::create("txn"); 

    start_item(txn); 

      txn.randomize()with{txn.s==0; txn.r==rst;}; 

    #5; 

    finish_item(txn); 

    rst=rst+1; 

  end 

  endtask:body 

  //---------------------------------------------------------------------------- 

   

endclass 

 

 

/*************************************************** 

** class name  : sequence_3 

** description : first unknown and then memory state 

***************************************************/ 

class sequence_3 extends sr_sequence; 

  //----------------------------------------------------------------------------    

  `uvm_object_utils(sequence_3)       

  //---------------------------------------------------------------------------- 

   

  sr_sequence_item txn; 

  int unsigned LOOP=20; 

  bit ukn=1; 

  //---------------------------------------------------------------------------- 

  function new(string name="sequence_3"); 

      super.new(name); 

  endfunction 

  //---------------------------------------------------------------------------- 

   

  //---------------------------------------------------------------------------- 

  task body(); 

    for(int i=0;i<LOOP;i++) begin  

    txn=sr_sequence_item::type_id::create("txn"); 

    start_item(txn); 

    txn.randomize()with{txn.s==ukn; txn.r==ukn;}; 

    #5; 

    finish_item(txn); 

    ukn = ukn + 1; 

  end 

  endtask:body 

  //---------------------------------------------------------------------------- 

   

endclass 
