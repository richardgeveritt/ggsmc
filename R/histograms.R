AncestorValue = Target = ExternalTarget = ParameterName = Parameter = Dimension = Value = Target = LogWeight = Iteration = ExternalIndex = Particle = Chain = NULL

#' A histogram of a single variable.
#'
#' @param output Output from the SMC or EnK algorithm.
#' @param parameter The parameter we wish to histogram.
#' @param dimension (optional) The dimension of the parameter we wish to histogram. (default is 1)
#' @param target (optional) The index of the target we wish to histogram. (default to all targets)
#' @param external_target (optional) The index of the external target to plot. (default is to use all external targets, or to ignore if the column is not present)
#' @param use_initial_points (optional) If target is not specified and this argument is TRUE, will add the initial unweighted proposed points to the output to be plotted. (default is TRUE)
#' @param use_weights (optional) If FALSE, will ignore particle weights in the histogram. If TRUE, will use the particle weights. (defaults to TRUE)
#' @param mcmc (optional) If TRUE, the user is indicating that the output is from an MCMC algorithm. This will set use_initial_points=FALSE and use_weights=FALSE no matter what the user sets these arguments to. (default is FALSE)
#' @param bins (optional) Number of bins for the histogram. (default 30)
#' @param xlimits (optional) Input of the form c(start,end), which specifies the ends of the x-axis.
#' @param ylimits (optional) Input of the form c(start,end), which specifies the ends of the y-axis.
#' @param default_title (optional) If TRUE, will provide a default title for the figure. If FALSE, no title is used. (defaults to FALSE)
#' @return A histogram in a ggplot figure.
#' @export
plot_histogram = function(output,
                          parameter,
                          dimension=1,
                          target=NULL,
                          external_target=NULL,
                          use_initial_points=TRUE,
                          use_weights=TRUE,
                          mcmc=FALSE,
                          bins=30,
                          xlimits=NULL,
                          ylimits=NULL,
                          default_title=FALSE)
{

  if (!("Value" %in% names(output)))
  {
    stop('Require tidy data with column "Value" as input to this function.')
  }

  if (!is.null(target) && !(target %in% output$Target))
  {
    stop('Specified target not found in output.')
  }

  if (!is.null(external_target) && !("ExternalTarget" %in% names(output)))
  {
    stop("ExternalTarget column not found in output.")
  }

  if (mcmc==TRUE)
  {
    use_initial_points = FALSE
    use_weights = FALSE
  }

  # if (is.null(target))
  # {
  #   target = max(output$Target)
  # }

  target_data = extract_target_data(output,target,external_target,use_initial_points)
  output_to_use = target_data[[1]]
  target_parameters = target_data[[2]]

  output_to_use = poorman::filter(poorman::filter(output_to_use,ParameterName==parameter),Dimension==dimension)

  if ( ("LogWeight" %in% names(output)) && (use_weights==TRUE) )
  {
    plot = ggplot2::ggplot(output_to_use, ggplot2::aes(Value, weight = exp(LogWeight)))
  }
  else
  {
    plot = ggplot2::ggplot(output_to_use, ggplot2::aes(Value))
  }

  if (length(unique(output$Dimension))==1)
  {
    parameter_for_plot = parameter
    if (is.null(target) || (target_parameters=="") )
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(parameter))
    }
    else
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(parameter)~"("*.(target_parameters)*")")
    }
  }
  else
  {
    if (is.null(target) || (target_parameters=="") )
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(parameter)[.(dimension)])
    }
    else
    {
      default_title_for_plot = bquote("Histogram of the density of"~.(parameter)[.(dimension)]~"("*.(target_parameters)*")")
    }
    parameter_for_plot = bquote(.(parameter)[.(dimension)])
  }

  plot = plot + ggplot2::geom_histogram(bins=bins) +
    ggplot2::xlab(parameter_for_plot) +
    ggplot2::ylab("density")

  if (default_title)
  {
    plot = plot + ggplot2::labs(title=default_title_for_plot)
  }

  if ( (!is.null(xlimits)) && (is.numeric(xlimits)) && (is.vector(xlimits)) )
  {
    plot = plot + ggplot2::coord_cartesian(xlim=c(xlimits[1],xlimits[2]))
  }

  if ( (!is.null(ylimits)) && (is.numeric(ylimits)) && (is.vector(ylimits)) )
  {
    plot = plot + ggplot2::coord_cartesian(ylim=c(ylimits[1],ylimits[2]))
  }

  return(plot)
}

#' An animated histogram of a single variable across targets.
#'
#' @param output Output from the SMC or EnK algorithm.
#' @param parameter The parameter we wish to histogram.
#' @param dimension (optional) The dimension of the parameter we wish to histogram. (default is 1)
#' @param target (optionaL) If specified, will fix to this target, and animate over ExternalTarget (if present in output).
#' @param external_target (optionaL) If specified, will fix to this external_target, and animate over Target.
#' @param use_initial_points (optional) If target is not specified and this argument is TRUE, will add the initial unweighted proposed points to the output to be plotted. (default is TRUE)
#' @param use_weights (optional) If FALSE, will ignore particle weights in the histogram. If TRUE, will use the particle weights. (defaults to TRUE)
#' @param mcmc (optional) If TRUE, the user is indicating that the output is from an MCMC algorithm. This will set use_initial_points=FALSE and use_weights=FALSE no matter what the user sets these arguments to. (default is FALSE)
#' @param bins (optional) Number of bins for the histogram. (default 30)
#' @param xlimits (optional) Input of the form c(start,end), which specifies the ends of the x-axis.
#' @param ylimits (optional) Input of the form c(start,end), which specifies the ends of the y-axis.
#' @param default_title (optional) If TRUE, will provide a default title for the figure. If FALSE, no title is used. (defaults to FALSE)
#' @param duration (optional) The duration of the animation. (defaults to producing an animation that uses 10 frames per second)
#' @param animate_plot (optiional) If TRUE, will return an animation. If FALSE, returns a gganim object that can be further modified before animating. (defaults to FALSE)
#' @param save_filename (optional) If specified, the animation will be saved to a gif with this filename. (default is not to save)
#' @param save_path (optional) If specified along with save_filename, will save the gif to save_path/save_filename. (defaults to working directory)
#' @return An animated histogram
#' @export
animate_histogram = function(output,
                              parameter,
                              dimension=1,
                              target=NULL,
                              external_target=NULL,
                              use_initial_points=TRUE,
                              use_weights=TRUE,
                             mcmc=FALSE,
                              bins=30,
                              xlimits=NULL,
                              ylimits=NULL,
                              default_title=FALSE,
                              duration=NULL,
                              animate_plot=TRUE,
                              save_filename=NULL,
                              save_path=NULL)
{

  p = plot_histogram(output = output,
                parameter = parameter,
                dimension = dimension,
                target = target,
                external_target = external_target,
                use_initial_points = use_initial_points,
                use_weights = use_weights,
                mcmc = mcmc,
                bins = bins,
                xlimits = xlimits,
                ylimits = ylimits,
                default_title = default_title)

  if (!is.null(external_target) && is.null(target))
  {
    to_animate = p + gganimate::transition_manual(Target)
    nframes = length(unique(output$Target))
  }
  else if (is.null(external_target) && !is.null(target))
  {
    if ("ExternalTarget" %in% names(output))
    {
      to_animate = p + gganimate::transition_manual(ExternalTarget)
      nframes = length(unique(output$ExternalTarget))
    }
    else
    {
      stop("ExternalTarget not specified in output, so cannot animate over it.")
    }
  }
  else if (!is.null(external_target) && !is.null(target))
  {
    stop("Both target and external_target are specified, so no animation to be done.")
  }
  else
  {
    if ("ExternalTarget" %in% names(output))
    {
      stop("Neither target nor external_target are specified: must specify one or the other when ExternalTarget is present in output.")
    }
    else
    {
      to_animate = p + gganimate::transition_manual(Target)
      nframes = length(unique(output$Target))
    }
  }

  if (animate_plot)
  {
    if (is.null(duration))
    {
      animated = gganimate::animate(to_animate,nframes=nframes)
    }
    else
    {
      animated = gganimate::animate(to_animate,nframes=nframes,duration=duration)
    }

    if (!is.null(save_filename))
    {
      if (is.null(save_path))
      {
        gganimate::anim_save(filename=save_filename,animation=animated)
      }
      else
      {
        gganimate::anim_save(filename=save_filename,animation=animated,path=save_path)
      }
    }

    return(animated)
  }
  else
  {
    if (!is.null(save_filename))
    {
       stop("Cannot save, since plot not animated.")
    }
    else
    {
      return(to_animate)
    }
  }

}
