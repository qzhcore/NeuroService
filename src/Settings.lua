local Settings = {
    -- Performance & Batching
    Max_Task_Per_Frame = 20,
    Default_Throttle = 0.1,

   -- LOD (Level of Detail)
  Lod_Enabled = true,
  Distance_Far = 300,
  Throttle_Far

   -- Debugging
   Debug = false,
}

return table.freeze(Settings)
  
