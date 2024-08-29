ResourceLibrary
{
   name = "DMG",
   ImageLibrary
   {
      Image{ name = "ModelingPlane", file = "ModelingPlane.png" },
      Image{ name = "VertexActiveHover", file = "VertexActiveHover.png" },
      Image{ name = "VertexActive", file = "VertexActive.png" },
      Image{ name = "VertexHover", file = "VertexHover.png" },
      Image{ name = "VertexPassive", file = "VertexPassive.png" },
      Image{ name = "SnapAxisDrop", file = "MovePoint_AxisConstrained.png" },
      Image{ name = "SnapCenterCandidate", file = "SnapCenterCandidate.png" },
      Image{ name = "SnapCenterDrop", file = "SnapCenterDrop.png" },
      Image{ name = "SnapPointDrop", file = "SnapPointDrop.png" },
      Image{ name = "SnapCurveDrop", file = "SnapCurveDrop.png" },
      Image{ name = "SnapSurfaceDrop", file = "SnapSurfaceDrop.png" },
      Image{ name = "GroundPlane", file = "GroundPlane.png" },
   },

   ImageSet
   {
      name = "CenterSnapResult",
      ImageItem{ type = "default", name = "SnapCenterDrop" },
      ImageItem{ type = "highlight", name = "SnapCenterDrop" },
      ImageItem{ type = "selected", name = "SnapCenterDrop" },
   },

   ImageSet
   {
      name = "CenterSnapCandidate",
      ImageItem{ type = "default", name = "SnapCenterCandidate" },
      ImageItem{ type = "highlight", name = "SnapCenterCandidate" },
      ImageItem{ type = "selected", name = "SnapCenterCandidate" },
   },

   ImageSet
   {
      name = "PointSnapResult",
      ImageItem{ type = "default", name = "SnapPointDrop" },
      ImageItem{ type = "highlight", name = "SnapPointDrop" },
      ImageItem{ type = "selected", name = "SnapPointDrop" },
   },

   ImageSet
   {
      name = "CurveSnapResult",
      ImageItem{ type = "default", name = "SnapCurveDrop" },
      ImageItem{ type = "highlight", name = "SnapCurveDrop" },
      ImageItem{ type = "selected", name = "SnapCurveDrop" },
   },

   ImageSet
   {
      name = "SurfaceSnapResult",
      ImageItem{ type = "default", name = "SnapSurfaceDrop" },
      ImageItem{ type = "highlight", name = "SnapSurfaceDrop" },
      ImageItem{ type = "selected", name = "SnapSurfaceDrop" },
   },

   ImageSet
   {
      name = "AxisSnapResult",
      ImageItem{ type = "default", name = "SnapAxisDrop" },
      ImageItem{ type = "highlight", name = "SnapAxisDrop" },
      ImageItem{ type = "selected", name = "SnapAxisDrop" },
   }
}

