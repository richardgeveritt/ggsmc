add_proposed_points <- function(output)
{
  min_target = min(output$Target)
  proposed_points = dplyr::filter(output,Target==min_target)
  proposed_points$LogWeight = matrix(-log(nrow(proposed_points)),nrow(proposed_points))
  proposed_points$Target = matrix(min_target-1,nrow(proposed_points))
  if ("TargetParameters" %in% names(output))
  {
    proposed_points$TargetParameters = matrix("proposal",nrow(proposed_points))
  }
  return(rbind(proposed_points,output))
}
